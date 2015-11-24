#!/bin/bash
set -eux

TMP="/tmp/aero-collect-logs"
TMP_LOGS="${TMP}/logs"
LOG_FILENAME="aerofs-appliance-logs.tar.gz"

mkdir -p ${TMP_LOGS}
cd ${TMP}

# Collect logs from the docker containers.
echo "Collecting logs from Aero docker containers..."

CONTAINERS=$(docker ps -a | rev | awk 'NR > 1 {print $1}'| rev)
for container in ${CONTAINERS}
do
    docker logs -t ${container} > ${TMP_LOGS}/${container}.log 2>&1
done
tar -zcvf ${LOG_FILENAME} -C ${TMP_LOGS} .
chmod +r ${LOG_FILENAME}
rm -rf ${TMP_LOGS}

# Start a simple HTTP server to serve up the logs files.
wget -q https://raw.githubusercontent.com/aerofs/aero-collect-logs/master/bashttpd
chmod +x bashttpd
echo "serve_file ${TMP}/${LOG_FILENAME}" > bashttpd.conf

echo "Serving log file over HTTP on port 8080..."
ncat -klp 8080 -e ${TMP}/bashttpd

cd -
rm -rf ${TMP}
