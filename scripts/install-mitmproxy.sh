# mitmproxy installation

sudo apt-get update && sudo apt-get install python3 python3-pip python3-venv -y
python3 -m pip install --user pipx && python3 -m pipx ensurepath
/home/vagrant/.local/bin/pipx install mitmproxy
sudo cp /vagrant/config/mitmproxy.service /etc/systemd/system/
sudo systemctl enable mitmproxy
sudo systemctl start mitmproxy

# Flows in mitmweb are kept in memory, never flushed and never cleared automatically. 
# During TFE installation a large number of images are downloaded. As a result the mitmweb process will quickly build up memory usage and eventually be reaped by the kernel oom_killer.
# For this reason the simpler solution (start mitmweb in the background) used in earlier versions of this repo has been discard and replaced by an auto restarting systemd service : 
#   bash -c 'nohup /home/vagrant/.local/pipx/venvs/mitmproxy/bin/python /home/vagrant/.local/bin/mitmweb --showhost --web-host=192.168.20.10 --web-port=8081 &'
