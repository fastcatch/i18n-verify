Gem::Specification.new do |s|
  gem.name = "i18n-verify"
  gem.homepage = "http://github.com/fastcatch/i18n-verify"
  gem.license = "MIT"
  gem.summary = %Q{Tools to verify your Ruby on Rails localizations}
  gem.description = %Q{It helps you find keys, undefined translations, duplicate keys, and more}
  gem.email = "axz10@cwru.edu"
  gem.authors = ["fastcatch"]
  
  s.files        = Dir.glob("{lib/**/*") + %w(LICENSE, README.markdown)
  s.require_path = 'lib'
end