#!/usr/bin/env bash
pm2 logs wss-tunnel --lines 200 --nostream \
| grep -Eo 'https://[a-z0-9-]+\.trycloudflare\.com' \
| tail -1