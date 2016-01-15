# Logstash, Elasticsearch, Riemann, Influxdb, Kibana, Collectd

This is my scaffold script to set up a local logging stack. It is extremely useful and will save you hours of restarting if you have to work with config files and test the entire flow of logs.

Just download this repo, work with the config files until you're happy with the flow and then move them to your real environment. 
# Usage 

Just run the main script.
```
./setup.sh
```
This will set up/restart entire stack for you.


To follow all the logs use ./follow_logs.sh (then use ctrl+c to close all windows). This works if you use a gnome-based system, otherwise you will have to update the script to use something else than gnome-terminal.

To send some fake logs to logstash use: 
```
sudo pip install -r requirements.txt
python make-logs.py
```

This stack exposes two UI's:
- Kibana - port 5601
- Influxdb - port 8083

Works with Docker version 1.9.1.
