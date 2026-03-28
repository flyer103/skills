#!/bin/bash
# Track daily xurl usage

LOG_FILE="${XURL_LOG_FILE:-$HOME/.xurl_usage.log}"
TODAY=$(date +%Y-%m-%d)

# Create log file if it doesn't exist
touch "$LOG_FILE"

# Count posts today
COUNT=$(grep "$TODAY" "$LOG_FILE" 2>/dev/null | wc -l | tr -d ' ')

echo "📊 XURL Usage Today: $COUNT posts"

# Warning thresholds
if [ $COUNT -ge 50 ]; then
  echo "⚠️  WARNING: Approaching daily limit (50 posts)"
  echo "Recommend: Switch to manual posting"
elif [ $COUNT -ge 30 ]; then
  echo "⚠️  Caution: High posting frequency today"
elif [ $COUNT -ge 20 ]; then
  echo "ℹ️  Note: Moderate posting today"
else
  echo "✅ Usage within normal range"
fi

# Show recent posts
echo ""
echo "Recent posts today:"
grep "$TODAY" "$LOG_FILE" | tail -5

exit 0
