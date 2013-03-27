# encoding: UTF-8
module OrganizationSeed
  puts " -- Creating organizations"
  organization = Organization.find_or_create_by_name(:name => "System")
  organization.update_attribute(:system, true)
end

module UserSeed
  puts " -- Creating users"
  organization = Organization.find_by_name("System")
  user = organization.users.find_or_create_by_email(:email => "admin@netsmarts.com", :first_name => "Системный", :last_name => "администратор", :middle_name => "netsmarts.ru", :password => "password")
  user.update_attribute(:admin, true)
  user.update_attribute(:organization_admin, true)
end
