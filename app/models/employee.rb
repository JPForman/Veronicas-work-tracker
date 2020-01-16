class Employee < ApplicationRecord
  has_many :employee_projects
  has_many :projects, :through => :employee_projects, dependent: :destroy
  validates :name, :division_id, presence: true

  scope :start_letter, -> (letter_parameter) { where("name ilike ?", "#{letter_parameter}%")}
  scope :most_projects, -> do (
    select("employees.id, employees.name, count(projects.id) as projects_count")
    .joins(:projects)
    .group("employees.id")
    .order("projects_count DESC")
    .limit(10))
  end

  scope :tenure, -> (division_id_paramater) do (
    where(division_id: division_id_paramater)
    .order("created_at ASC"))
  end

  scope :newest, -> (division_id_paramater) do (
    where(division_id: division_id_paramater)
    .order("created_at DESC"))
  end
end
