#!/usr/bin/env bash

DEV=${1-/}
REQUESTSIZE="1024 4 32 64 256"
COUNT=5

if [[ ! $(which ioping) ]]; then
	apt-get install ioping
fi

function drop_cache {
	echo 3 > /proc/sys/vm/drop_caches
	sleep 4
}

function stats {
	local str=$(echo "$2" | grep -E '(iops|mdev)')
	if [[ $str =~ ([0-9]+)\ requests\ completed\ in\ ([0-9\.]+)\ ms,\ ([0-9]+)\ iops,\ ([0-9\.]+)\ mb\/s.*min\/avg\/max\/mdev\ =\ ([0-9\.]+)\/([0-9\.]+)\/([0-9\.]+)\/([0-9\.]+)\ ms ]]; then
		printf '%-32s %6d %8s %6d %6s %6s %6s %6s %6s \n' "$1" ${BASH_REMATCH[1]} ${BASH_REMATCH[2]} ${BASH_REMATCH[3]} ${BASH_REMATCH[4]} ${BASH_REMATCH[5]} ${BASH_REMATCH[6]} ${BASH_REMATCH[7]} ${BASH_REMATCH[8]}
	fi
}

echo ""
echo "Sequential disk speed test (dd)"
echo "==============================="
cd /tmp
drop_cache
dd if=/dev/zero of=testfilex bs=64k count=16k conv=fdatasync
rm -rf testfilex

echo ""
echo "Disk latency tests (ioping)"
echo "==========================="
printf "%-32s %6s %8s %6s %6s %6s %6s %6s %6s \n" Test req ms iops mb/s min avg max mdev

for WSIZE in $REQUESTSIZE; do
	drop_cache
	stats "Disk I/O rate (${WSIZE}KB)" "$(ioping -c ${COUNT} -s ${WSIZE}K ${DEV})"
done

for WSIZE in $REQUESTSIZE; do
	drop_cache
	stats "Seek rate (${WSIZE}KB)" "$(ioping -R -s ${WSIZE}K ${DEV})"
done

drop_cache
stats "Sequential seek rate" "$(ioping -RL ${DEV})"

stats "Sequential cached seek rate" "$(ioping -RLC ${DEV})"

echo ""
