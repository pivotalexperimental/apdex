begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "apdex"
    s.executables = "apdex"
    s.summary = "Calculate apdex scores from an Apache or Nginx log"
    s.email = "pivotallabsopensource@googlegroups.com"
    s.homepage = "http://github.com/pivotal/apdex"
    s.description = "Calculate apdex scores from an Apache or Nginx log"
    s.authors = ["Chad Woolley", "Brian Takita", "Pivotal Labs"]
    s.files =  FileList["[A-Z]*", "{bin,generators,lib,test}/**/*", 'lib/apdex/templates/.gitignore']
  end
rescue LoadError
  puts "apdex, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-apdex -s http://gems.github.com"
end
