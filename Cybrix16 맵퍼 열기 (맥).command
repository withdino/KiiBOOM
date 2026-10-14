#!/bin/bash
# Cybrix 16 맵퍼를 Chrome에서 엽니다. (더블클릭으로 실행)
cd "$(dirname "$0")"
PORT=8716
if ! lsof -iTCP:$PORT -sTCP:LISTEN >/dev/null 2>&1; then
  nohup python3 -m http.server $PORT --bind 127.0.0.1 >/dev/null 2>&1 &
  sleep 1
fi
open -a "Google Chrome" "http://localhost:$PORT/index.html"
osascript -e 'tell application "Terminal" to close (every window whose name contains "Cybrix16")' >/dev/null 2>&1 &
exit 0
