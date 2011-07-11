require 'i18n_verify'
require 'rails'
module I18nVerify
  class Railtie < Rails::Railtie
    railtie_name :i18n_verify

    rake_tasks do
      load "tasks/i18n_verify.rake"
    end
  end
end