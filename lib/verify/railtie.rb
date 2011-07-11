require 'verify'

module Verify
  class VerifyRailtie < Rails::Railtie
    rake_tasks do
      load "tasks/verify.rake"
    end
  end
end
