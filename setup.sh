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
sudo ufw enable
// here we are getting the status of the fire wall to confirm that it is active.
sudo apt-get install postgresql postgresql-contrib -y
sudo apt-get -y install git 