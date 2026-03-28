# Twitter API Rate Limits Reference

## Official Rate Limits

### Tweets (Write)

| Endpoint | Limit | Window |
|----------|-------|--------|
| Post tweet | 300 | 3 hours |
| Delete tweet | 300 | 3 hours |
| Retweet | 300 | 3 hours |

### Tweets (Read)

| Endpoint | Limit | Window |
|----------|-------|--------|
| Get tweets | 900 | 15 minutes |
| Search tweets | 180 | 15 minutes |
| User timeline | 900 | 15 minutes |

### User Operations

| Endpoint | Limit | Window |
|----------|-------|--------|
| Get followers | 15 | 15 minutes |
| Get following | 15 | 15 minutes |
| Follow/Unfollow | 400 | 24 hours |

## Practical Rate Limits (Observed)

### Automated Posting Safety Margins

**Conservative** (recommended):
- **1 post per hour** maximum
- **24 posts per day** maximum
- **30 minute minimum** between posts

**Moderate** (acceptable):
- **2 posts per hour** maximum
- **50 posts per day** maximum
- **15 minute minimum** between posts

**Aggressive** (risky):
- **4 posts per hour** maximum
- **100 posts per day** maximum
- **5 minute minimum** between posts

### Bulk Operation Cooldowns

After bulk operations, wait before posting:

| Operation Count | Cooldown Period |
|-----------------|-----------------|
| 1-10 deletes | 30 minutes |
| 10-50 deletes | 1 hour |
| 50+ deletes | 2 hours |

## Rate Limit Detection

### Response Codes

- **403 Forbidden**: Rate limit or content filter
- **429 Too Many Requests**: Explicit rate limit
- **200 OK**: Success

### Check Headers

```bash
# Verbose mode shows headers (DO NOT USE IN AGENT SESSIONS)
# xurl -v post "test"  # Shows X-RateLimit-Remaining
```

### Practical Test

```bash
# If whoami works but post fails → content filter
xurl whoami  # Success → check content
xurl post "test"  # 403 → content issue

# If whoami fails → rate limit or auth issue
xurl whoami  # 403 → rate limited
```

## Rate Limit Recovery Strategy

### Tier 1: Short Wait (15 minutes)

For minor rate limits:
```bash
sleep 900
# Retry
```

### Tier 2: Medium Wait (1 hour)

For moderate rate limits:
```bash
sleep 3600
# Retry
```

### Tier 3: Long Wait (24 hours)

For severe rate limits:
```bash
# Switch to manual posting or different account
# Wait 24 hours before retrying automation
```

## Monitoring Rate Limits

### Track Usage

```bash
# Create a simple log
echo "$(date): Posted tweet" >> ~/.xurl_usage.log

# Check post count today
grep "$(date +%Y-%m-%d)" ~/.xurl_usage.log | wc -l
```

### Automated Tracking

```bash
# scripts/track_usage.sh
#!/bin/bash
TODAY=$(date +%Y-%m-%d)
COUNT=$(grep "$TODAY" ~/.xurl_usage.log 2>/dev/null | wc -l)
echo "Posts today: $COUNT"

if [ $COUNT -gt 50 ]; then
  echo "⚠️  Approaching daily limit"
fi
```

## Best Practices Summary

1. **Start conservative**: 1 post/hour, 30+ minute gaps
2. **Monitor responses**: Watch for 403/429 codes
3. **Log usage**: Track posts per day
4. **Have backup plan**: Manual posting option ready
5. **Respect cooldowns**: Wait after bulk operations

## When Rate Limited

1. **Don't retry immediately**: Wait at least 15 minutes
2. **Check content**: Ensure it's not a content filter
3. **Log the incident**: Note time and error
4. **Adjust strategy**: Reduce posting frequency
5. **Consider manual**: Switch to manual posting temporarily
