#!/usr/bin/ruby
require 'pg'
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')


 DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/') do
  project = Project.new({title: params.fetch("title"), id: nil})
  project.save
  @projects = Project.all
  erb(:index)
end

get ('/projects/:id') do
  @project = Project.find(params["id"].to_i)
  @volunteers = @project.volunteers
  erb(:project)
end

get ('/projects/:id/edit') do
  @project = Project.find(params["id"].to_i)
  erb(:project_edit)
end

patch ('/projects/:id') do
  id = params["id"].to_i
  @project = Project.find(id)
  @project.update({title: params.fetch("title"), id: id})
  @volunteers = @project.volunteers
  erb(:project)
end

delete("/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  erb(:index)
end

post('/projects/:id') do
  project_id = params.fetch("id").to_i()
  volunteer = Volunteer.new({name: params.fetch("name"), id: nil, project_id: project_id})
  volunteer.save
  @project = Project.find(project_id)
  @volunteers = @project.volunteers
  erb(:project)
end

patch ('/volunteers/:id') do
  id = params.fetch("id").to_i()
  puts id
  puts params.fetch("id").to_i()
  new_name = params.fetch("name")
  @volunteer = Volunteer.find(id)
  @volunteer.update({id: id, name: new_name, project_id: @volunteer.project_id})
  @project = Project.find(@volunteer.project_id)
  erb(:volunteer_details)
end

get ('/volunteers/:id') do

  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @project = Project.find(@volunteer.project_id)
  erb(:volunteer_details)
end
