---
name: research-to-environment-handoff
description: Generates a comprehensive session handoff doc when transitioning from a desktop research/ideation session to Claude Code or Cowork. Use when the goal and direction are clear but implementation has not started. Produces a structured markdown file capturing all decisions, workflows, model choices, open questions, and next steps.
triggers:
  - "make me a handoff doc"
  - "create a handoff for this session"
  - "summarize this session for claude code"
  - "transition to claude code"
  - "wrap up this research session"
version: 1.0
author: tuan
---

# Skill: Research-to-Environment Handoff

## When to use this skill

Use this skill when a research or ideation session in the desktop Claude app has reached the point where:
- The goal and direction are clear
- The approach and key decisions are made
- The next step is transitioning to a richer tool environment (Claude Code or Cowork)
- Implementation has NOT started yet

This is NOT a "start coding" signal. It is a "carry full context cleanly into the next environment" signal.

## What this skill produces

A single `session-handoff.md` file that serves as the source of truth for:
- What was discussed and decided
- What models/platforms/tools were chosen and why
- The two or more workflows defined
- What remains open/undecided
- The recommended first step in the next environment

## Skill instructions

When the user asks for a handoff doc at the end of a research session:

### 1. Reconstruct the session scope

Pull together:
- The original question or problem statement
- Each major prompt the user gave (in order)
- The direction the session moved toward

Do not summarize vaguely. Capture actual decisions made.

### 2. Document all key decisions as a table

For every meaningful choice made in the session (model, platform, workflow structure, approach), record:
- The decision
- What was chosen
- Why (1 sentence rationale)

### 3. Diagram or describe both/all workflows

If the user defined multiple workflows (e.g., research pipeline + generation pipeline), document each as a clear step-by-step flow. Use ASCII arrows (`→` or `↓`) for clarity. Include:
- Trigger or input
- Each processing step
- Output or destination

### 4. Capture the decision matrix

For each stage in the workflow, list the tools/models considered with cost and tradeoffs. Use tables.

### 5. Call out open questions explicitly

Anything that was NOT resolved in this session that must be resolved before implementation goes in a dedicated "What has not been decided yet" section. These become the first agenda items in the next environment.

### 6. Add a compliance or risk section if relevant

For domains like AI-generated content, ads, or regulated verticals: include legal/compliance notes that affect implementation.

### 7. Set the next environment context

End the doc with a short paragraph describing:
- Which environment to open next (Claude Code vs Cowork)
- What to do first when you get there
- What NOT to do yet (e.g., "don't start implementation, resolve open questions first")

---

## Format rules

- Use YAML frontmatter: `title`, `date`, `session_type`, `next_env`, `tags`
- Use heading levels: `##` for major sections, `###` for subsections
- Tables for decisions and model comparisons
- ASCII step-by-step for workflows
- Bullet lists for open questions and compliance notes
- Keep it dense but scannable — this is a reference doc, not prose

---

## Template

```markdown
---
title: [Topic] — Session Handoff
date: [YYYY-MM-DD]
session_type: research → environment transition
next_env: [Claude Code / Cowork]
tags: [relevant, tags]
---

# Session Handoff: [Topic]

## What This Is
[1-2 sentences on what this session was and why it's being handed off]

## Session Goal
[Single clear statement of what we're trying to build/do]

## Prompts Given (Chronological)
[Numbered list of actual prompts, in order]

## Key Decisions Made
| Decision | Choice | Rationale |

## Workflows Defined

### Workflow 1: [Name]
[step → step → step]

### Workflow 2: [Name]
[step → step → step]

## Model + Platform Decision Matrix
[Tables per workflow stage]

## Key Open Questions
[Bullet list — these are agenda items for the next session]

## Compliance / Risk Notes
[If applicable]

## Monthly Cost Estimate
[Table with per-item costs and total]

## Files From This Session
[Table of any artifacts, guides, or outputs created]

## Next Environment
[What to open, what to do first, what to skip]
```

---

## Usage pattern

This skill is designed for a recurring flow:

```
Desktop Claude (research + ideation)
    ↓
[Goal clear, direction set, decisions made]
    ↓
Run this skill → generate session-handoff.md
    ↓
Open Claude Code or Cowork
    ↓
Load handoff doc as first context
    ↓
Continue: resolve open questions → architect → eventually implement
```

The handoff doc is the bridge. Its job is to eliminate the "let me re-explain everything" tax when switching environments.
