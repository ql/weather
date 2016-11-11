server '104.207.131.0', user: 'ql', roles: %w{app db web}
set :repo_url, 'git@github.com:ql/weather.git'
set :application, 'weather'
