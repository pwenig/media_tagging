# Viacom Media Tagging Project

* Rails v5.1 / Ruby v2.4
* Database - Production is current set to PostgreSQL. Dev is set to SQLite.

* To run locally:
  * Git clone repo
  * $bundle install
  * $rake db:create
  * $rake db:migrate
  * $bundle exec foreman start -f Procfile.dev
  * http://localhost:5000/

* To run RSpec tests:
  * $bundle exec rspec
