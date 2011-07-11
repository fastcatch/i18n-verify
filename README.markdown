i18n-verify
===========

This is a set of tools that make your life easier if you have lots of translations in a Rails project.

Installation
============

You normally would want to install this gem as stand-alons (i.e. not throu environment.rb / Gemfile) because it is not to be called from the application but as a command line utility.

Install it by:

    gem install i18n-verify
    
If you do want to include it in your environment.rb or Gemfile just insert the standard line (perhaps in the :development group in Gemfile; and don't forget to run `bundle install`.

Usage
=====

i18n-verify is a set of rake tasks:

* `rake i18n:find_key` for finding keys
* `rake i18n:is_complete` for checking if translations are complete
* `rake i18n:duplicates` for finding keys with more than one translation for any given locale

All of them will automatically pick up translation files configured for i18n (both yml and rb).

i18n:find_key
-------------

It looks for keys that match regexp.

Syntax:

    rake i18n:find_key[regexp,group_by_filename]

Beware with `regexp`: escape your period ('.') characters.  Output format is defined by `group_by_filename`.

Examples:

* `rake i18n:find_key[models]`
* `rake i18n:find_key[\.models\.attributes,true]`

i18n:is_complete
----------------

It checks pairs of locales for keys that are defined in one but not in the other.

Syntax:

    rake i18n:is_complete [locales=<list>]

`locales` defaults to all and should be a comma separated list with no spaces.

Examples:

* `rake i18n:is_complete`
* `rake i18n:is_complete locales=en,fr,es`

i18n:duplicates
----------------

It checks for keys that appear more than once in the translations for any given locale.  This is a nasty mistake because you can never be sure which one loads last thus becoming 'the' one in your app.

    rake i18n:duplicates [locales=<list>]

`locales` defaults to all and should be a comma separated list with no spaces.

Examples:

* `rake i18n:duplicates`
* `rake i18n:duplicates locales=en`

To do
=====

* Add spell checking support
* Write tests (tests for rake tasks, that is!)
* ...

Contributing to i18n-verify
===========================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========

Copyright (c) 2011 fastcatch. See LICENSE.txt for further details.
