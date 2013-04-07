unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end
 
Motion::Project::App.setup do |app|
  app.frameworks << 'MessageUI'
  Dir.glob(File.join(File.dirname(__FILE__), 'motion-inappmail/*.rb')).each do |file|
    app.files.unshift(file)
  end
end