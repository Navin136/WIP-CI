df -h
free -h
sudo fallocate -l 16G /nk/swapfile
sudo chmod 600 /nk/swapfile
sudo mkswap /nk/swapfile
sudo swapon /nk/swapfile
sudo swapon
free -h
