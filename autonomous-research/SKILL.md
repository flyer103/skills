---
name: autonomous-research
description: Set up and run autonomous research loops with Hermes Agent. Multi-profile orchestration via Kanban, fixed-budget iteration with independent evaluation.
version: 1.0.0
author: flyer103
platforms: [linux, macos]
metadata:
  hermes:
    tags: [research, autonomous, kanban, multi-agent, orchestration, org-design]
    category: research
    requires_toolsets: [terminal, file, kanban, skills]
    related_skills: [kanban-orchestrator, kanban-worker]
---

# Autonomous Research — Fixed-Budget Iteration with Multi-Agent Orchestration

> Inspired by karpathy/autoresearch. Aligned with ORG-DESIGN: #1 small iterations, #2 feedback-driven, #4 quality built-in, #6 knowledge compounding.

## When to Use

Three conditions: 1) Quantifiable metric, 2) Modifiable recipe, 3) Affordable per-experiment cost.

## Architecture

Six profiles via Kanban: orchestrator → researchers A/B → evaluator → reviewer → writer.

## ORG-DESIGN Alignment

| # | Principle | Implementation |
|---|-----------|---------------|
| 1 | Small iterations | One change per round |
| 2 | Feedback-driven | Evaluator metrics gate next round |
| 4 | Quality built-in | Independent evaluator + reviewer |
| 6 | Knowledge compounding | Baseline improves, skills accumulate |

## Reference

[auto-alpha](https://github.com/flyer103/auto-alpha) — complete working example.
Round 1: composite +114%, Sharpe turned positive.
