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

get ('/project/:id') do
  @project = Project.find(params["id"].to_i)
  erb(:project)
end

get ('/project/edit/:id') do
  @project = Project.find(params["id"].to_i)
  erb(:project_edit)
end

patch ('/project/:id') do
  id = params["id"].to_i
  @project = Project.find(id)
  @project.update({title: params.fetch("title"), id: id})
  erb(:project)
end
