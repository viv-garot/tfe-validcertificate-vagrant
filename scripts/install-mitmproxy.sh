# mitmproxy installation

sudo apt-get update && sudo apt-get install python3 python3-pip python3-venv -y
python3 -m pip install --user pipx && python3 -m pipx ensurepath
/home/vagrant/.local/bin/pipx install mitmproxy
bash -c 'nohup /home/vagrant/.local/pipx/venvs/mitmproxy/bin/python /home/vagrant/.local/bin/mitmweb --showhost --web-host=192.168.20.10 --web-port=8081 &'
