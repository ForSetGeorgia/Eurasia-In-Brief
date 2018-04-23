set :domain, 'theredlegacy.org'
set :user, 'ubuntu'
set :application, 'EurasiaInBrief'
# easier to use https; if you use ssh then you have to create key on server
set :repository, 'https://github.com/ForSetGeorgia/Eurasia-In-Brief.git'
set :branch, 'master'
set :web_url, ENV['PRODUCTION_WEB_URL']
set :use_ssl, true
set :identity_file_arg, '-i'
set :identity_file, 'redlegacy.pem'
set :puma_worker_count, '1'
set :puma_thread_count_min, '1'
set :puma_thread_count_max, '16'
