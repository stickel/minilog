namespace :minilog do
  
  # namespace :install do
    desc "Install minilog DB and run tests"
    task :install => :environment do
      # create and migrate the db
      Rake::Task['db:migrate'].invoke
      
      # set up restful_auth
      
    end
  # end
end