namespace :i18n do

  #
  # find_key helps to find where certain (partial) keys have translations
  #
  # the first parameter is a regexp to look for (beware of period separators!)
  # the second parameter is a flag if results are to be grouped by file
  #   (the default is one match per line with filename included)
  #
  # Examples:
  #   rake find_key[/models/]
  #   rake find_key[/\.models\.attributes/,true]
  #
  desc "Find translation keys matching a regexp"
  task :find_key, :regexp, :group_by_filename do |t, args|
    require "#{::Rails.root.to_s}/config/environment.rb"
    regexp = Regexp.new(args[:regexp] || "")
    group_by_filename = args[:group_by_filename]
    checker = I18nVerify::Checker.new(I18n.config.load_path)
    checker.find_key(regexp,group_by_filename)
  end

  #
  # is_complete helps in checking if all translations are set up in all directions
  # that is: verifies there are no missing keys in any of the trasnlations
  #
  # is_complete takes a command line rake param: the list of locales to check (all pairs)
  #   omit for all
  #
  # Examples:
  #   rake i18n:is_complete
  #   rake i18n:is_complete locales=en,de
  #
  desc "Checks if translations are complete or there are missing ones"
  task :is_complete do |t, args|
    require "#{::Rails.root.to_s}/config/environment.rb"
    locales_requested = (ENV['locales'] || "").downcase.split(',')
    checker = I18nVerify::Checker.new(I18n.config.load_path)
    checker.is_complete?(locales_requested)
  end

  #
  # duplicates helps in finding keys with multiple translations to the same locale
  #
  # redundancies takes a command line rake param: the list of locales to check
  #   omit for all
  #
  # Examples:
  #   rake i18n:duplicates
  #   rake i18n:duplicates locales=en,de
  #
  desc "Checks if any keys are translated multiple times"
  task :duplicates do |t, args|
    require "#{::Rails.root.to_s}/config/environment.rb"
    locales_requested = (ENV['locales'] || "").downcase.split(',')
    checker = I18nVerify::Checker.new(I18n.config.load_path)
    checker.duplicates(locales_requested)
  end

=begin
  # TODO: write method
  desc "Checks translations spellings"
  task :spelling do |t, args|
  end
=end

  desc "Run all checks"
  task :verify => [:is_complete, :duplicates] do
  end

end

#
# BONUS :)
#
namespace :yaml do
  desc "Finds keys in yaml files; regexp to match keys; command line: rake yaml:find[config/locales/**/*.yml,/\.models\./]"
  task :find, :filename_pattern, :regexp, :group_by_filename do |t, args|
    filenames = Dir[args[:filename_pattern] || Rails.root.join('**', '*.{yaml,yml}').to_s]
    regexp = Regexp.new(args[:regexp] || "")
    group_by_filename = args[:group_by_filename]

    filenames.each do |filename|
      print filename + ":\n" if group_by_filename

      File.open( filename ) do |infile|
        yaml_hash = YAML::parse(infile).transform
        flatten_keys( yaml_hash ) do |key, value|
          puts "#{group_by_filename ? '' : (filename + ' #')} #{key}: #{value}\n" if key =~ regexp
        end
      end

    end
  end
end