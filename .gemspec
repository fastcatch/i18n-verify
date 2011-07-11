Gem::Specification.new do |gem|
  gem.name         = "i18n-verify"
  gem.homepage     = "http://github.com/fastcatch/i18n-verify"
  gem.version      = "0.0.1"
  gem.platform     = Gem::Platform::RUBY
  gem.license      = "MIT"
  gem.summary      = %Q{Tools to verify your Ruby on Rails localizations}
  gem.description  = %Q{It helps you find keys, undefined translations, duplicate keys, and more}
  gem.email        = "axz10@cwru.edu"
  gem.authors      = ["fastcatch"]
  gem.files        = Dir.glob("{lib/**/*") + %w(LICENSE.txt README.markdown)
  gem.require_path = 'lib'
end