#!/bin/bash
# Safe posting script with rate limit handling

TWEET_TEXT="$1"
shift

# Parse optional media flag
MEDIA_ID=""
if [ "$1" = "--media" ]; then
  shift
  MEDIA_FILE="$1"
  shift

  # Upload media first
  echo "Uploading media..."
  UPLOAD_RESULT=$(xurl media upload "$MEDIA_FILE")
  MEDIA_ID=$(echo "$UPLOAD_RESULT" | jq -r '.data.media_id')

  if [ "$MEDIA_ID" = "null" ] || [ -z "$MEDIA_ID" ]; then
    echo "❌ Media upload failed"
    exit 1
  fi

  echo "✅ Media uploaded: $MEDIA_ID"
fi

# Check if we've posted recently
LAST_POST_FILE="/tmp/.xurl_last_post"
MIN_INTERVAL=1800  # 30 minutes

if [ -f "$LAST_POST_FILE" ]; then
  LAST_POST=$(cat "$LAST_POST_FILE")
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_POST))

  if [ $ELAPSED -lt $MIN_INTERVAL ]; then
    WAIT_TIME=$((MIN_INTERVAL - ELAPSED))
    echo "⏳ Rate limit: Waiting $WAIT_TIME seconds before posting..."
    sleep $WAIT_TIME
  fi
fi

# Attempt to post
echo "Posting tweet..."
if [ -n "$MEDIA_ID" ]; then
  RESULT=$(xurl post "$TWEET_TEXT" --media-id "$MEDIA_ID" 2>&1)
else
  RESULT=$(xurl post "$TWEET_TEXT" 2>&1)
fi

# Check for errors
if echo "$RESULT" | jq -e '.errors' > /dev/null 2>&1; then
  ERROR=$(echo "$RESULT" | jq -r '.errors[0].code // .errors[0].title')

  if [ "$ERROR" = "403" ] || [ "$ERROR" = "Forbidden" ]; then
    echo "❌ 403 Forbidden - Content may be filtered"
    echo "Tip: Check emoji count (max 1-2) and content quality"
    echo "Response: $RESULT"
    exit 1
  fi

  if [ "$ERROR" = "429" ] || [ "$ERROR" = "Too Many Requests" ]; then
    echo "❌ 429 Rate Limited"
    echo "Waiting 1 hour before retry..."
    sleep 3600

    # Retry once
    if [ -n "$MEDIA_ID" ]; then
      RESULT=$(xurl post "$TWEET_TEXT" --media-id "$MEDIA_ID" 2>&1)
    else
      RESULT=$(xurl post "$TWEET_TEXT" 2>&1)
    fi

    if echo "$RESULT" | jq -e '.errors' > /dev/null 2>&1; then
      echo "❌ Still rate limited after 1 hour"
      exit 1
    fi
  fi
fi

# Success
TWEET_ID=$(echo "$RESULT" | jq -r '.data.id')
echo "✅ Tweet posted successfully!"
echo "ID: $TWEET_ID"
echo "$RESULT" | jq '.data'

# Update last post timestamp
date +%s > "$LAST_POST_FILE"

# Log the post
echo "$(date): Posted tweet $TWEET_ID" >> ~/.xurl_usage.log

exit 0
