Pod::Spec.new do |s|
  s.name         = "Shouter"
  s.version      = "0.1.0"
  s.summary      = "A type safe, thread safe and memory safe alternative for NotificationCenter"
  s.homepage     = "https://github.com/ChaosCoder/Shouter"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "ChaosCoder" => "https://github.com/ChaosCoder" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/ChaosCoder/Shouter.git", :tag => s.version }
  s.source_files  = "Shouter/*.swift"
  s.requires_arc = true
end
