#pull down new code

cd ~/spartagramEnvironment
git pull
berks vendor cookbooks
sudo chef-client --local-mode --runlist 'recipe[rails-server]'


cd ~/SpartaGram
git pull
rbenv rehash
gem install bundler
rbenv rehash
bundle exec rake db:migrate
rails s
