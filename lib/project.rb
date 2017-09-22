class Project
  attr_reader :title, :id
  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end

  def == (other_project)
    self.title == other_project.title
  end
end
