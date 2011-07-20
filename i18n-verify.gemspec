# coding: UTF-8

Gem::Specification.new do |s|
  s.name              = "i18n-verify"
  s.homepage          = "http://github.com/fastcatch/i18n-verify"
  s.version           = "0.0.5"
  s.platform          = Gem::Platform::RUBY
  s.summary           = %Q{Tools to verify your Ruby on Rails localizations}
  s.description       = %Q{It helps you find keys, undefined translations, duplicate keys, and more}
  s.email             = "axz10@cwru.edu"
  s.authors           = ["fastcatch"]
  # s.rubyforge_project = s.name

  # s.required_rubygems_version = ">= 1.3.6"
  
  # If you have runtime dependencies, add them here
  # s.add_runtime_dependency "other", "~> 1.2"
  
  # If you have development dependencies, add them here
  # s.add_development_dependency "another", "= 0.9"

  # The list of files to be contained in the gem
  s.files         = `git ls-files`.split("\n")
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  s.require_path = 'lib'

  # For C extensions
  # s.extensions = "ext/extconf.rb"
end
