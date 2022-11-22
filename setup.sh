#!/bin/bash

## Django app setup

cd ~

sudo apt-get update && apt-get upgrade -y
sudo apt-get -y install python3-pip nginx -y
sudo pip3 install --upgrade pip
sudo apt-get install ufw -y
sudo ufw default allow outgoing -y 
sudo ufw default deny incoming -y
// run the command to allow ssh connection
sudo ufw allow ssh
// here we configure the fire wall to allow port 8000 
sudo ufw allow 8000
// here we are enabling the fire wall
sudo ufw --force  enable
// here we are getting the status of the fire wall to confirm that it is active.
sudo apt-get install postgresql postgresql-contrib -y
sudo apt-get -y install git 
mv eccommerce-1 eccommerce 
cd eccommerce
## Change pstgresql password 
sudo -u postgres psql -U postgres -d postgres -c "CREATE DATABASE website;"
sudo -u postgres psql -U postgres -d postgres -c "CREATE USER webuser WITH PASSWORD 'utrainsdb';"
sudo -u postgres psql -U postgres -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE website TO webuser;"
sudo service postgresql restart
echo  "Please double that database connexion string is goo"
cat demo/settings.py
sleep 20
pip3 install virtualenv
virtualenv venv
source venv/bin/activate
pip3 install -r requirements.txt
python manage.py collectstatic
python manage.py makemigrations
python manage.py migrate
python manage.py runserver 0.0.0.0:8000


