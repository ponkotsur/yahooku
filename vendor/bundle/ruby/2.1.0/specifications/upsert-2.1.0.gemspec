# -*- encoding: utf-8 -*-
# stub: upsert 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "upsert".freeze
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Seamus Abshere".freeze]
  s.date = "2015-03-18"
  s.description = "Make it easy to upsert on MySQL, PostgreSQL, and SQLite3. Transparently creates merge functions for MySQL and PostgreSQL; on SQLite3, uses INSERT OR IGNORE.".freeze
  s.email = ["seamus@abshere.net".freeze]
  s.homepage = "https://github.com/seamusabshere/upsert".freeze
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Make it easy to upsert on MySQL, PostgreSQL, and SQLite3. Transparently creates merge functions for MySQL and PostgreSQL; on SQLite3, uses INSERT OR IGNORE.".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec-core>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-expectations>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-mocks>.freeze, [">= 0"])
      s.add_development_dependency(%q<activerecord>.freeze, ["~> 3"])
      s.add_development_dependency(%q<active_record_inline_schema>.freeze, [">= 0"])
      s.add_development_dependency(%q<faker>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<pg-hstore>.freeze, [">= 1.1.3"])
      s.add_development_dependency(%q<sequel>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1.1"])
      s.add_development_dependency(%q<activerecord-import>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<mysql2>.freeze, [">= 0"])
      s.add_development_dependency(%q<pg>.freeze, [">= 0"])
      s.add_development_dependency(%q<redcarpet>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec-core>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-expectations>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-mocks>.freeze, [">= 0"])
      s.add_dependency(%q<activerecord>.freeze, ["~> 3"])
      s.add_dependency(%q<active_record_inline_schema>.freeze, [">= 0"])
      s.add_dependency(%q<faker>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<pg-hstore>.freeze, [">= 1.1.3"])
      s.add_dependency(%q<sequel>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.1.1"])
      s.add_dependency(%q<activerecord-import>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<mysql2>.freeze, [">= 0"])
      s.add_dependency(%q<pg>.freeze, [">= 0"])
      s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec-core>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-expectations>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-mocks>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, ["~> 3"])
    s.add_dependency(%q<active_record_inline_schema>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pg-hstore>.freeze, [">= 1.1.3"])
    s.add_dependency(%q<sequel>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1.1"])
    s.add_dependency(%q<activerecord-import>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
  end
end
