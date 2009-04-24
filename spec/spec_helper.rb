require "rubygems"
require "spec"
require "spec/autorun"
dir = File.dirname(__FILE__)
$:.unshift(File.expand_path("#{dir}/../lib"))
require "apdex"

Spec::Runner.configure do |config|
  config.mock_with :rr
end
