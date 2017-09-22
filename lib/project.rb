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
    @id = result.first.fetch("id").to_i
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

  def self.find(id)
    found_project = nil
    Project.all.each do |project|
      if project.id == id
        found_project = project
      end
    end
    found_project
  end

  def volunteers
    volunteers = []
    raw_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = '#{@id}'")
    raw_volunteers.each do |volunteer|
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      name = volunteer.fetch("name")
      volunteers.push(Volunteer.new({id: id, project_id: project_id, name: name}))
    end
    volunteers
  end

  def update(attributes)
    @id = self.id
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end
end
