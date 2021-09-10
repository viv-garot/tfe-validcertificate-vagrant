# mitmproxy installation

sudo apt-get update && sudo apt-get install python3 python3-pip python3-venv -y
python3 -m pip install --user pipx && python3 -m pipx ensurepath
/home/vagrant/.local/bin/pipx install mitmproxy
bash -c 'nohup /home/vagrant/.local/pipx/venvs/mitmproxy/bin/python /home/vagrant/.local/bin/mitmweb --no-web-open-browser --showhost &'

# --set stream_large_bodies=10m
