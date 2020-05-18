#!/bin/sh

if [ "${ANALYTICS_ENABLED}" = "false" ]; then
    echo "($0) Analytics disabled; skipping metric submission"
    exit 0
fi

# See: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters
# Tracking ID
tid=$ANALYTICS_TRACKING_ID
# Application Name
an=$ANALYTICS_APP_NAME
# Application Version
av=$PUPPET_SERVER_VERSION
# Anonymous Client ID
_file=/var/tmp/pwclientid
cid=$(cat $_file 2>/dev/null || (cat /proc/sys/kernel/random/uuid | tee $_file))
# Event Category
ec=${ANALYTICS_STREAM:-dev}
# Event Action
ea=start
# Anonymize ip
aip=1

_params="v=1&t=event&tid=${tid}&an=${an}&av=${av}&cid=${cid}&ec=${ec}&ea=${ea}&aip=${aip}"
_url="http://www.google-analytics.com/collect?${_params}"

echo "($0) Sending metrics ${_url}"
curl --fail --silent --show-error --output /dev/null \
    -X POST -H "Content-Length: 0" $_url
