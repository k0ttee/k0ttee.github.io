#!/bin/sh

# СКРИПТ сколько оперативки занимают процессы и потоко php-fpm (работает в macOS и Alpine Linux)

PROCESS_NAME="php-fpm"
PIDS=$(pgrep "$PROCESS_NAME")

[ -z "$PIDS" ] && { echo "Процесс '$PROCESS_NAME' не запущен."; exit 0; }

DATA=$(echo "$PIDS" | xargs -I {} ps -o rss=,command= -p {});

echo "$DATA" | awk '{
	memory_mb = $1 / 1024;
	cmd = substr($0, index($0,$2));
	printf "%8.1f MB  %s\n", memory_mb, cmd;
}'

exit;







# ОДНОСТРОЧНИК сколько оперативки занимают процессы и потоко php-fpm (работает в macOS и Alpine Linux)

x='php-fpm'; pgrep "$x" | xargs -I {} ps -o rss,command -p {} | awk -v proc="$x" '$0 ~ proc {printf "%s %.1fM\n", proc, $1/1024}'
