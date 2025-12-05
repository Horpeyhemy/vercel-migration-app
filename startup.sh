#!/bin/bash
set -e
 
cd /home/site/wwwroot

echo "=== Installing production dependencies ==="
npm ci --omit=dev || npm install --omit=dev

echo "=== Building Next.js app (standalone output) ==="
npm run build

echo "=== Starting standalone Next.js server ==="
node .next/standalone/server.js
