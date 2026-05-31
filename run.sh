#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"

# Auto-create venv if missing
if [ ! -d "$DIR/venv" ]; then
    echo "[run.sh] tworzę venv..."
    python3 -m venv "$DIR/venv"
fi

# Install deps if missing
if [ ! -f "$DIR/venv/.installed" ]; then
    echo "[run.sh] instaluję zależności..."
    "$DIR/venv/bin/pip" install fastapi uvicorn -q
    touch "$DIR/venv/.installed"
fi

# Kill any existing daemon on port 19876
fuser -k 19876/tcp 2>/dev/null || true

# Start daemon in background
"$DIR/venv/bin/python" "$DIR/daemon/daemon.py" &
DAEMON_PID=$!

# Wait for daemon to start then launch GUI
sleep 3
"$DIR/venv/bin/python" "$DIR/gui/manager.py" &

wait $DAEMON_PID
