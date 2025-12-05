#!/bin/bash
set -e

echo "=== Startup: cd to /home/site/wwwroot ==="
cd /home/site/wwwroot

echo "=== Installing production dependencies ==="
# Prefer clean install if lockfile exists
if [ -f package-lock.json ]; then
  npm ci --only=production || npm install --production
else
  npm install --production
fi

echo "=== Building Next.js app ==="
npm run build

echo "=== Starting Next.js app ==="
npm start
