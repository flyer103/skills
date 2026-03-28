---
name: xurl-best-practices
description: Best practices and guidelines for using xurl CLI tool effectively with X (Twitter) API, including rate limits, content guidelines, optimal posting times, and error handling. Use when working with xurl for automated posting, engagement, or any Twitter API operations to avoid rate limits, content blocks, and optimize performance.
---

# xurl Best Practices

Guidelines for effective automated posting with xurl based on real-world usage patterns.

## Critical Rules

### 1. Emoji Limitations

**❌ FORBIDDEN**:
- Excessive emoji (>3 per tweet)
- Multiple emoji in lists or formatting
- Decorative emoji in every line

**✅ ALLOWED**:
- 1-2 emoji per tweet maximum
- Functional emoji only (e.g., one ✅ for checklists)

**Why**: Twitter API blocks tweets with excessive emoji with 403 Forbidden error.

### 2. Rate Limiting

**Minimum intervals**:
- Between posts: **30 minutes** minimum
- After bulk operations (deletes): **1 hour** before posting
- Daily post limit: **50 tweets/day** (recommended safe limit)

**Rate limit recovery**:
```
403 Forbidden → Wait 60-90 minutes → Retry
```

### 3. Content Guidelines

**Avoid**:
- Marketing-heavy language
- Excessive formatting
- ALL CAPS
- Repetitive content
- Hashtags at start of tweet

**Best practices**:
- Clear, concise language
- 1-2 relevant hashtags at end
- Natural conversational tone
- Value-focused content

## Posting Strategy

### Optimal Times (Beijing Time)

**Weekdays**:
- Morning: 10:00-11:00
- Afternoon: 15:00-16:00
- Evening: 20:00-21:00

**Weekends**:
- Morning: 10:00-11:00
- Evening: 18:00-19:00

### Posting Frequency

- **Minimum**: 1 post per day
- **Recommended**: 2-3 posts per day
- **Maximum**: 5 posts per day (with 2+ hour gaps)

### Content Mix

**Week 1 example**:
- Day 1: Project introduction
- Day 2: Technical tip
- Day 3: Official announcement
- Day 4: Case study/user story
- Day 5: Light/engaging content
- Day 6: Industry insight
- Day 7: Engagement/poll

## Error Handling

### 403 Forbidden

**Causes**:
1. Rate limit exceeded
2. Content flagged (excessive emoji, spam-like)
3. Short interval after bulk operations

**Solution**:
```bash
# Check if rate limited
xurl whoami  # If this works, it's content filtering

# For rate limits
sleep 3600  # Wait 1 hour

# For content filtering
# Remove emoji, simplify language, retry
```

### 429 Too Many Requests

**Solution**:
```bash
# Wait until reset (check headers)
sleep 900  # 15 minutes default
```

## Automated Posting Workflow

### Safe Posting Script

Use `scripts/safe_post.sh`:

```bash
# Post with automatic rate limit handling
scripts/safe_post.sh "Your tweet text here"

# With media
scripts/safe_post.sh "Check this out" --media photo.jpg
```

### Batch Posting Strategy

For multiple tweets:

1. **Schedule, don't spam**:
   ```bash
   # Post tweet 1
   xurl post "First tweet"

   # Wait 30 minutes
   sleep 1800

   # Post tweet 2
   xurl post "Second tweet"
   ```

2. **Use background timers**:
   ```bash
   # Schedule tweets with exec background
   exec command:"xurl post 'Tweet at 3pm'" background:true
   ```

## Content Templates

### Project Announcement

```
Just open sourced [PROJECT NAME]

A [BRIEF DESCRIPTION] that [VALUE PROPOSITION]

Install:
[INSTALL COMMAND]

Features:
- [Feature 1]
- [Feature 2]
- [Feature 3]

GitHub: [LINK]

#Hashtag1 #Hashtag2
```

### Technical Tip

```
[TOPIC] tip:

[Problem statement]

Example:
- [Example 1]
- [Example 2]

[Solution]

#Hashtag1 #Hashtag2
```

## Monitoring & Metrics

### Track Performance

```bash
# Check your recent posts
xurl timeline -n 10

# Check mentions
xurl mentions -n 20

# Check engagement (likes, retweets)
xurl likes -n 10
```

### Success Metrics

- **Week 1**: 5-10 likes per tweet average
- **Month 1**: 20-50 likes per tweet average
- **Engagement rate**: >5% of followers

## Advanced Usage

For detailed rate limits, content filtering rules, and advanced patterns:
- **Rate limits**: See [references/rate-limits.md](references/rate-limits.md)
- **Content guidelines**: See [references/content-guidelines.md](references/content-guidelines.md)

## Common Patterns

### Project Launch Sequence

1. **Teaser** (Day 1): "Working on something exciting..."
2. **Hint** (Day 2): Technical insight or tip related to project
3. **Launch** (Day 3): Official announcement with GitHub link
4. **Follow-up** (Day 4-7): Case studies, user stories

### Engagement Strategy

```bash
# Morning: Post content
xurl post "New blog post: [TITLE] [LINK] #Tech"

# Afternoon: Engage with replies
xurl mentions -n 20

# Evening: Share insights
xurl post "Key takeaway from today: [INSIGHT]"
```

## Quick Reference

| Action | Command | Notes |
|--------|---------|-------|
| Safe post | `scripts/safe_post.sh "text"` | Auto rate limit handling |
| Check limits | `xurl whoami` | Verify auth status |
| Wait after delete | `sleep 3600` | 1 hour after bulk delete |
| Max emoji | 1-2 per tweet | Or 403 Forbidden |
| Min post interval | 30 minutes | Avoid rate limits |
