#pull down new code

cd ~/spartagramEnvironment
kill -9 $(lsof -i tcp:3000 -t)
git pull
sudo berks vendor cookbooks
sudo chef-client --local-mode --runlist 'recipe[rails-server]'


cd ~/SpartaGram
git pull
bundle
bundle exec rake db:migrate
rails s
