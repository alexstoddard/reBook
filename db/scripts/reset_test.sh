#load 'db/seeds/herokutest.rb'
#heroku config -r herokutest | grep POSTGRESQL
#heroku run rails console -r herokutest
heroku pg:reset HEROKU_POSTGRESQL_GRAY_URL --remote herokutest --confirm rebooktest
heroku run rake db:migrate --remote herokutest
heroku run rails runner "db/seeds/herokutest.rb" --remote herokutest
