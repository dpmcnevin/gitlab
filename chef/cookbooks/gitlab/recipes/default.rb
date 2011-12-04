rvm_shell "run bundler" do
  # ruby_string "1.9.2"
  # user        "git"
  # group       "git"
  cwd         node[:gitlab][:path]
  code        %{bundle}
end

rvm_shell "set up database" do
  cwd node[:gitlab][:path]
  code %{RAILS_ENV=production rake db:setup; RAILS_ENV=production rake db:seed_fu}
  creates "#{node[:gitlab][:path]}/db/production.sqlite3"
end
