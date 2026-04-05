# 任务示例

> 本文档包含合格和不合格的任务描述示例

---

## ✅ 合格的任务描述

### 示例 1：每日科技新闻汇总

```markdown
# 每日科技新闻汇总

## 基本信息

| 项目 | 值 |
|------|-----|
| **任务名称** | 每日科技新闻汇总 |
| **执行时间** | 0 8 * * * (Asia/Shanghai) |
| **推送目标** | Discord Channel ID: 1477544896071073956 |
| **创建时间** | 2026-04-05 |

## 数据来源

- Hacker News: https://news.ycombinator.com/
- TechCrunch: https://techcrunch.com/
- ProductHunt: https://www.producthunt.com/

## 输出要求

| 项目 | 要求 |
|------|------|
| **格式** | Markdown 列表 |
| **条目数** | TOP 5 |
| **每条字数** | ≤ 100 字 |
| **包含内容** | 标题、摘要、来源链接 |

## 存储配置

- 数据库: PostgreSQL (localhost:5432/openclaw)
- 表名: daily_tech_news
- 字段: id, title, summary, source, url, created_at
```

---

### 示例 2：每周 GitHub Trending

```markdown
# 每周 GitHub Trending

## 基本信息

| 项目 | 值 |
|------|-----|
| **任务名称** | 每周 GitHub Trending |
| **执行时间** | 0 9 * * 1 (Asia/Shanghai) - 每周一 09:00 |
| **推送目标** | Discord Channel ID: 1477544896071073956 |
| **创建时间** | 2026-04-05 |

## 数据来源

- GitHub Trending: https://github.com/trending
- 语言: Python, TypeScript, Rust

## 输出要求

| 项目 | 要求 |
|------|------|
| **格式** | Markdown 表格 |
| **条目数** | TOP 10 |
| **每条包含** | 仓库名、描述、stars 数、语言 |

## 执行逻辑

1. 访问 GitHub Trending 页面
2. 按 stars 数排序
3. 筛选指定语言
4. 提取 TOP 10 仓库信息
5. 格式化为 Markdown 表格
```

---

## ❌ 不合格的任务描述

### 反例 1：模糊的任务

```markdown
任务名称：每日新闻

执行时间：每天早上

数据来源：新闻网站

输出要求：总结今日新闻

推送目标：Discord
```

**问题分析**：

| # | 问题 | 改进建议 |
|---|------|---------|
| 1 | ❌ "每天早上" | → 具体时间 + 时区：`0 8 * * * (Asia/Shanghai)` |
| 2 | ❌ "新闻网站" | → 指定具体网站：Hacker News, TechCrunch |
| 3 | ❌ "总结" | → 指定格式和字数：Markdown 列表，每条 ≤ 100 字 |
| 4 | ❌ "Discord" | → 指定 Channel ID：`1477544896071073956` |

---

### 反例 2：缺少关键信息

```markdown
# 股票分析

每天分析股票
```

**问题分析**：

| # | 缺失信息 | 必须添加 |
|---|---------|---------|
| 1 | ❌ 执行时间 | cron 表达式 + 时区 |
| 2 | ❌ 推送目标 | Discord Channel ID |
| 3 | ❌ 数据来源 | API 或网站 URL |
| 4 | ❌ 输出格式 | Markdown/JSON/文本 |
| 5 | ❌ 基本信息表格 | 必须包含 |

---

## 📝 格式检查清单

创建任务时，确保：

- [ ] 标题使用 `#` 作为任务名称
- [ ] 章节使用 `##` 
- [ ] 基本信息使用表格格式
- [ ] 执行时间包含时区
- [ ] Channel ID 是纯数字
- [ ] 数据来源使用 Markdown 列表
- [ ] 输出要求使用表格
