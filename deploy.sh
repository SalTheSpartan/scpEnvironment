#pull down new code

cd ~/spartagramEnvironment
git pull
sudo berks vendor cookbooks
sudo chef-client --local-mode --runlist 'recipe[rails-server]'


cd ~/SpartaGram
git pull
gem install bundler
bundle
bundle exec rake db:migrate
rails s
