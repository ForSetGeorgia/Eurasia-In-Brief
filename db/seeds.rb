# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

roles = %w(super_admin site_admin content_manager)
roles.each do |role|
  Role.find_or_create_by(name: role)
end

# if this is not production
# and variable is set, create users if not exist
if ENV['create_user_accounts'].present? && !Rails.env.production?
  puts "LOADING TEST USER ACCOUNTS"
  User.find_or_create_by(email: 'super.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 1
  end

  User.find_or_create_by(email: 'site.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 2
  end

  User.find_or_create_by(email: 'content.manager@test.ge') do |u|
    puts "creating content manager"
    u.password = 'password123'
    u.role_id = 3
  end
end



# create country records
if ENV['create_country_records'].present?
  puts "LOADING COUNTRIES"

  countries = [
    'Armenia',
    'Azerbaijan',
    'Belarus',
    'Georgia',
    'Kazakhstan',
    'Kyrgyzstan',
    'Moldova',
    'Russia',
      'Tajikistan',
    'Turkmenistan',
    'Ukraine',
    'Uzbekistan'
  ]

  countries.each do |country|
    Country.find_or_create_by(name: country) do |u|
      puts "creating country #{country}"
    end
  end
end


# create test records
if ENV['create_test_records'].present? && !Rails.env.production?
  puts "LOADING TEST RECORDS"
  require 'csv'

  puts "- deleting existing records"
  Story.destroy_all
  TimePeriod.destroy_all

  puts "- getting records"
  data = CSV.read("#{Rails.root}/db/data/test_data.csv")
  # remove headers
  data.delete_at(0)

  # get countries
  countries = Country.sorted

  # create the time period records
  puts "- creating time periods"
  time_periods = []
  months = {'January' => 1, 'February' => 2, 'March' => 3}
  tps = data.map{|x| x[1]}.uniq
  tps.each do |tp|
    order = months[tp.split(' ').first]
    time_periods << TimePeriod.create(is_published: true, label: tp, order: order)
  end

  # create the stories
  puts "- creating stories"
  data.each do |story|
    tp = time_periods.select{|x| x.label == story[1]}.first
    c = countries.select{|x| x.name == story[2]}.first
    s = Story.create(locale: story[0], time_period_id: tp.id, country_id: c.id, title: story[3], link: story[4], content: "<p>#{story[5]}</p>")
  end

end