desc 'clear the database of user information' 
task :cron => :environment do 
  deleted_user_count = User.destroy_all.count
  deleted_registration_count = Registration.destroy_all.count
  puts "deleted #{deleted_user_count} users and #{deleted_registration_count} registrations without users"
end 
