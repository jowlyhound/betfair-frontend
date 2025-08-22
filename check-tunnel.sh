#!/usr/bin/env bash

# Get current tunnel URL
TUNNEL_URL=$(pm2 logs wss-tunnel --lines 200 --nostream | grep -Eo 'https://[a-z0-9-]+\.trycloudflare\.com' | tail -1)

if [ -z "$TUNNEL_URL" ]; then
  echo "❌ No tunnel URL found in PM2 logs"
  exit 1
fi

echo "🔗 Current tunnel: $TUNNEL_URL"

# Convert https to wss for WebSocket testing
WSS_URL="${TUNNEL_URL/https/wss}"
echo "📡 WebSocket URL: $WSS_URL"

# Test if tunnel is responsive
if curl -s --max-time 5 "$TUNNEL_URL" > /dev/null; then
  echo "✅ Tunnel is responsive"
else
  echo "❌ Tunnel not responding"
  exit 1
fi