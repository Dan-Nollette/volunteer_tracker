class Volunteer
  attr_reader :name, :project_id, :id
  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end

  def == (other_volunteer)
    self.name == other_volunteer.name
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_volunteers =  DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id")
      project_id = volunteer.fetch("project_id")
      volunteers.push(Volunteer.new({id: id.to_i, project_id: project_id.to_i, name: name}))
    end
    volunteers
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all.each do |volunteer|
      if volunteer.id == id
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end
end
