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
  erb(:project)
end

delete("/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  erb(:index)
end
