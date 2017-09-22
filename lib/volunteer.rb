class Volunteer
  attr_reader :name, :project_id
  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end

  def == (other_volunteer)
    self.name == other_volunteer.name
  end
end
