# This file is used by Rack-based servers to start the application.

require 'bootstrap-sass' #  http://stackoverflow.com/questions/13285568/rails-3-2-bootstrap-sass-not-installing?rq=1

require ::File.expand_path('../config/environment',  __FILE__)
run SampleApp::Application


