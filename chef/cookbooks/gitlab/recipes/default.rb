rvm_shell "run bundler" do
  # ruby_string "1.9.2"
  # user        "git"
  # group       "git"
  cwd         "/vagrant"
  # code        %{rake RAILS_ENV=production db:migrate}
  code        %{bundle}
end

rvm_shell "set up database" do
  cwd "/vagrant"
  code %{RAILS_ENV=production rake db:setup; RAILS_ENV=production rake db:seed_fu}
  creates "/vagrant/db/production.sqlite3"
end
