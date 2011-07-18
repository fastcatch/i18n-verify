module I18nVerify
  class I18nVerifyRailtie < Rails::Railtie
    rake_tasks do
      load "tasks/verify.rake"
    end
  end
end
