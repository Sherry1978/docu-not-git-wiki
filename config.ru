require 'sinatra/lib/sinatra.rb'
require 'rubygems'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)

require 'git-wiki'
run Sinatra.application