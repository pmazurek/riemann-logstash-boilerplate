containers="kibana-local\|influxdb-local\|riemann-local\|logstash-local\|elasticsearch-local\|collectd-local"

docker build -t logstash-with-riemann docker-logstash

docker kill $(docker ps -a | grep $containers | awk '{print $1}') 2>/dev/null
docker rm -f $(docker ps -a | grep $containers | awk '{print $1}') 2>/dev/null

docker run --name=influxdb-local -p 8083:8083 -p 8086:8086 \
    -e PRE_CREATE_DB=riemann-local \
    -e INFLUXDB_INIT_PWD=password \
    -d tutum/influxdb

docker run --name=logstash-local \
    -p "5043:5043" \
    -v "$(pwd)/conf/logstash:/config-dir" \
    -d logstash-with-riemann -f /config-dir/logstash.conf --verbose

docker run --name=elasticsearch-local \
    -p "9200:9200" \
    -p "9300:9300" \
    -d elasticsearch 

docker run --name=riemann-local \
    -p "5555:5555" \
    -p "5556:5556" \
    -v "$(pwd)/conf/riemann:/opt/riemann/etc" \
    -e RIEMANN_INFLUXDB_DBHOST=influxdb-local \
    -e RIEMANN_INFLUXDB_DBNAME=riemann-local \
    -e RIEMANN_INFLUXDB_USER=root \
    -e RIEMANN_INFLUXDB_PASSWORD=password \
    -d pmazurek/riemann

docker run --name=collectd-local \
    -e CONFIG_TYPE=riemann \
    -e EP_HOST=riemann-local \
    -e EP_PORT=5555 \
    -d revett/collectd

docker run --name kibana-local \
    --link elasticsearch-local:elasticsearch \
    -p 5601:5601 \
    -d kibana
