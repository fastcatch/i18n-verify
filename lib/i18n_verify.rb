# the user interface is in rake tasks 
# for more info see lib/tasks/i18n-verify.rake

module I18nVerfiy

  require 'i18n-verify/railtie' if defined?(Rails)

  class Checker
    def initialize(filenames = )
      @translations = load_files(filenames)
    end
    
    def find_key(match=Regexp,new(''), group_by_filename=false)
      # select translations with matching keys
      matching_translations = @translations.select {|t| [t[:locale],t[:key]].join('.') =~ regexp}

      # print matching translations
      if group_by_filename
        matching_translations.group_by {|t| t[:filename]}.each_pair do |filename, translations|
          puts "#{filename}:"
          translations.each do |t|
            puts " #{[t[:locale],t[:key]].join('.')}: #{t[:translation]}\n"
          end
        end
      else
        matching_translations.each do |t|
          puts "#{t[:filename]} # #{[t[:locale],t[:key]].join('.')}: #{t[:translation]}\n"
        end
      end
    end
    
    def is_complete?(locales_requested = [])      
      # check each pair of locales
      #   if the first one has keys the second one doesn't => these are the incomplete translations
      locales = @translations.collect{|tr| tr[:locale]}.uniq
      locales_to_check = locales_requested.empty? ? locales : (locales & locales_requested)

      puts "Checking locales #{locales_to_check.inspect} out of #{locales.inspect} for completeness"
      locales_to_check.permutation.each do |first, second|
        first_translations = @translations.select {|translation| translation[:locale] == first}
        second_translations = @translations.select {|translation| translation[:locale] == second}

        differences = first_translations.select {|f| f if second_translations.none? {|s| f[:key]==s[:key]} }.compact
        if differences.empty?
          puts "#{first} => #{second}: complete\n"
        else
          puts "Missing from #{second} vs. #{first}:\n"
          differences.each do |difference|
            puts " " + [difference[:locale], difference[:key]].join('.') + " defined for #{first} in #{difference[:filename]}\n"
          end
        end
      end
    end
    
    def duplicates(locales_requested = [])
      locales = @translations.collect{|tr| tr[:locale]}.uniq
      locales_to_check = locales_requested.empty? ? locales : (locales & locales_requested)

      puts "Checking locales #{locales_to_check.inspect} out of #{locales.inspect} for redundancy"

      # collect and print duplicate translations
      locales_to_check.each do |locale|
        puts "#{locale}:"
        translations_by_key = @translations.select {|t| t[:locale] == locale}.uniq.group_by {|t| t[:key]}
        translations_by_key.reject {|t| t[1].count == 1}.each_pair do |key, translations|
          puts " #{key}: #{translations.collect{|t| t[:filename]}.join(", ")}"
        end
      end
    end
    
    protected
    # convert translations hash to flat keys
    # i.e. from { :de => {:new => neue, :old => alt} } to [ ['de.new', 'neue'], ['de.old', 'alte'] ]
    # and yields a flat key and the value to the block
    def flatten_keys(hash, prev_key=nil, &block)
      hash.each_pair do |key, value|
        curr_key = [prev_key, key].compact.join('.')
        if value.is_a?(Hash)
          flatten_keys(value, curr_key, &block)
        else
          yield curr_key, value
        end
      end
    end

    # read files and store translations (similar to i18n's internals but include filenames)
    def load_files(filenames)
      translations = []
      filenames.each do |filename|
        type = File.extname(filename).tr('.', '').downcase.to_sym
        case type
          when :rb
            data = eval IO.read(filename) # , binding, filename)
          when :yml
            data = YAML.load_file(filename)
          else
            raise I18n::UnknownFileType.new(type, filename)
        end
        raise I18n::InvalidLocaleData.new(filename) unless data.is_a?(Hash)
        data.each_pair do |locale, d|
          flatten_keys(d || {}) do |flat_key, translation|
            translations.push({ :filename => filename, :locale => locale.to_s, :key => flat_key, :translation => translation })
          end
        end
      end
      translations
    end
    
  end
  
end