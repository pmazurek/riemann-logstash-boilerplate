gnome-terminal -x sh -c "echo \"=== RIEMANN LOGS ===\"; docker logs --follow riemann-local ; bash"
gnome-terminal -x sh -c "echo \"=== LOGSTASH LOGS ===\"; docker logs --follow logstash-local ; bash"
gnome-terminal -x sh -c "echo \"=== COLLECTD LOGS ===\"; docker logs --follow collectd-local; bash"
gnome-terminal -x sh -c "echo \"=== INFLUXDB LOGS ===\"; docker logs --follow influxdb-local; bash"
gnome-terminal -x sh -c "echo \"=== ELASTICSEARCH LOGS ===\"; docker logs --follow elasticsearch-local; bash"

control_c()
# run if user hits control-c
{
  # kill all docker logs terminals
  kill $(ps aux | grep "docker logs"| awk '{print $2}')
  exit $?
}
 
# trap keyboard interrupt (control-c)
trap control_c SIGINT
 
# main() loop
while true; do read x; done

