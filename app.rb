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
