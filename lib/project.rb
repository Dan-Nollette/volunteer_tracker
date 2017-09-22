class Project
  attr_reader :title, :id
  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end

  def == (other_project)
    self.title == other_project.title
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each do |project|
      id = project.fetch("id")
      title = project.fetch("title")
      projects.push(Project.new({id: id.to_i, title: title}))
    end
    projects
  end
end
