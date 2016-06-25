# -*- encoding: utf-8 -*-
# stub: clockwork 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "clockwork".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Wiggins".freeze, "tomykaira".freeze]
  s.date = "2016-04-15"
  s.description = "A scheduler process to replace cron, using a more flexible Ruby syntax running as a single long-running process.  Inspired by rufus-scheduler and resque-scheduler.".freeze
  s.email = ["adam@heroku.com".freeze, "tomykaira@gmail.com".freeze]
  s.executables = ["clockwork".freeze, "clockworkd".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze, "bin/clockwork".freeze, "bin/clockworkd".freeze]
  s.homepage = "http://github.com/tomykaira/clockwork".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.3".freeze
  s.summary = "A scheduler process to replace cron.".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<daemons>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.8"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
    else
      s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<daemons>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.8"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<daemons>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.8"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
  end
end
