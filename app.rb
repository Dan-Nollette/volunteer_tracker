#!/usr/bin/ruby
require 'pg'
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')


 DB = PG.connect({:dbname => 'volunteer_tracker'})
