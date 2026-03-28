# Twitter Content Guidelines for Automation

## Content Filtering Triggers

### Automatic Blocks (403 Forbidden)

These content patterns commonly trigger 403 Forbidden:

1. **Excessive Emoji**
   - ❌ 3+ emoji per tweet
   - ❌ Emoji in every line of a list
   - ❌ Decorative emoji sequences

2. **Spam Indicators**
   - ❌ ALL CAPS TEXT
   - ❌ Excessive punctuation (!!!)
   - ❌ Repetitive hashtags (#tag #tag #tag)
   - ❌ Same content posted repeatedly

3. **Marketing Language**
   - ❌ "BUY NOW", "LIMITED TIME", "ACT FAST"
   - ❌ Excessive superlatives ("AMAZING", "INCREDIBLE")
   - ❌ Clickbait phrases

4. **Formatting Issues**
   - ❌ Multiple consecutive line breaks (>3)
   - ❌ Bullet points with emoji in every item
   - ❌ Long hashtags (>20 chars)

### Safe Content Patterns

✅ **Clean formatting**:
```
Just open sourced my new project

Features:
- Feature 1
- Feature 2
- Feature 3

GitHub: link

#kubernetes #opensource
```

✅ **Minimal emoji**:
```
Working on a K8s tool to save cloud costs

Problem: Most clusters waste 20-40% on over-provisioning

Solution:
- Auto-analyze usage
- Generate recommendations
- One-click apply

GitHub: link

#kubernetes
```

## Content Quality Guidelines

### Tweet Structure

**Opening** (1-2 lines):
- Clear value proposition
- Hook to grab attention
- No emoji in first line

**Body** (2-5 lines):
- Concise explanation
- Bullet points (optional)
- One emoji maximum (if needed)

**Closing** (1-2 lines):
- Call to action
- Link
- Hashtags (max 2)

### Hashtag Best Practices

**DO**:
- ✅ 1-2 relevant hashtags at end
- ✅ Use established hashtags (#kubernetes, #devops)
- ✅ Place after main content

**DON'T**:
- ❌ More than 3 hashtags
- ❌ Hashtags at start of tweet
- ❌ Long hashtags (>15 chars)
- ❌ Hashtag spamming

### Emoji Guidelines

**Safe usage**:
- ✅ 1 emoji per tweet (functional)
- ✅ Use for clarity, not decoration

**Avoid**:
- ❌ 2+ emoji per tweet
- ❌ Emoji in every list item
- ❌ Emoji sequences (✅ ❌ 💡 🔥)

**Examples**:

✅ Good:
```
New feature: Auto-scaling

Benefits:
- Saves cost
- Improves performance
- Easy setup

GitHub: link
```

❌ Bad:
```
🚀 New feature: Auto-scaling

✅ Benefits:
✅ Saves cost
✅ Improves performance
✅ Easy setup

🔗 GitHub: link

#kubernetes #devops #cloud
```

## Content Templates

### Product Launch

```markdown
Just open sourced [PROJECT_NAME]

[BRIEF_DESCRIPTION] that saves [METRIC]

Install:
[COMMAND]

Features:
- [Feature_1]
- [Feature_2]
- [Feature_3]

GitHub: [URL]

#Hashtag1 #Hashtag2
```

**Emoji budget**: 0-1 (optional in title)

### Technical Tip

```markdown
[TOPIC] tip:

[PROBLEM_STATEMENT]

Example:
- [Example_1]
- [Example_2]

[Solution]

#Hashtag1 #Hashtag2
```

**Emoji budget**: 0

### Case Study

```markdown
Case study: How [CLIENT] saved [METRIC]

Situation:
[Brief context]

Solution:
[What you did]

Result:
[Outcome with numbers]

[Call to action or link]

#Hashtag1
```

**Emoji budget**: 0-1 (for result section)

## Testing Content

### Pre-Post Checklist

Before posting, check:

- [ ] Emoji count ≤ 1
- [ ] Hashtag count ≤ 2
- [ ] No ALL CAPS
- [ ] No excessive punctuation
- [ ] Clear, concise language
- [ ] Links work
- [ ] Value proposition clear

### A/B Testing

Test different versions:

**Version A** (with emoji):
```
New tool to save K8s costs

Features:
- Auto-analyze
- Recommendations
- Easy apply

GitHub: link

#kubernetes
```

**Version B** (without emoji):
```
New tool to save K8s costs

Auto-analyze your cluster and get recommendations

Features:
- 7-day analysis
- Optimization tips
- One-click apply

GitHub: link

#kubernetes
```

## Common Mistakes

### Mistake 1: Over-Formatting

❌ Too much:
```
🚀 EXCITING NEWS! 🚀

Just launched:

✅ Feature 1
✅ Feature 2
✅ Feature 3

🔥 Link: url

#tag1 #tag2 #tag3 #tag4
```

✅ Better:
```
Just launched a new K8s tool

Auto-analyze and optimize your cluster resources

Features:
- 7-day analysis
- Smart recommendations
- One-click apply

GitHub: url

#kubernetes
```

### Mistake 2: Clickbait

❌ Avoid:
```
You WON'T BELIEVE this tool!

It will SAVE YOU THOUSANDS!!!

Click here NOW 👇
```

✅ Use:
```
Tool to reduce K8s cloud costs

Most clusters waste 20-40% on over-provisioning

My tool helps identify and fix this

GitHub: link
```

## Content Calendar Strategy

### Weekly Mix

- **Monday**: Project/product update
- **Tuesday**: Technical tip
- **Wednesday**: Major announcement
- **Thursday**: Case study/story
- **Friday**: Light/engaging content
- **Saturday**: Industry insight
- **Sunday**: Engagement/poll

### Tone by Day

**Weekdays**: Professional, informative
**Weekends**: Lighter, conversational

## Monitoring Content Performance

### Success Indicators

- **Likes**: >5 per tweet (week 1)
- **Retweets**: >1 per tweet
- **Replies**: Engagement is good
- **Link clicks**: Check analytics

### Failure Indicators

- **403 errors**: Content filtering issue
- **0 engagement**: Content not resonating
- **Unfollows**: Too promotional

## Iteration Process

1. **Post content**
2. **Monitor for 24 hours**
3. **Check engagement metrics**
4. **Note any 403 errors**
5. **Adjust next post based on learnings**

## Quick Reference

| Content Element | Rule | Reason |
|----------------|------|--------|
| Emoji | ≤1 per tweet | Avoid 403 filter |
| Hashtags | ≤2 per tweet | Better reach |
| ALL CAPS | Never | Spam trigger |
| Line breaks | ≤2 consecutive | Clean look |
| Punctuation | Normal use | Avoid spam filter |
| Links | 1 per tweet | Optimal engagement |
