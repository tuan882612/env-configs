name: add-gotcha
desc: Adds a new entry to ~/.claude/rules/gotchas.md in the correct tool group. Use when a new tooling failure, footgun, or non-obvious workaround is discovered.
triggers:
  - "/add-gotcha"
  - "add this to gotchas"
  - "log this as a gotcha"
  - "add gotcha"
version: 1.0
author: tuan

# Skill: Add Gotcha

## When to use

Use when a non-obvious tool failure, footgun, or workaround is discovered during work that would waste time if hit again. Not for general bugs in user code - only for tooling/MCP/CLI quirks.

## Steps

### 1. Collect the three required fields

Use AskUserQuestion to collect:
- **Tool**: which tool or MCP server (e.g. `mcp__obsidian-personal`, `gh`, `modal`, `lean-ctx`)
- **What failed**: one-line description of the failure or symptom
- **Workaround**: what actually works instead

If the user already provided all three in their message, skip the prompt and extract them directly.

### 2. Read the current gotchas file

Read `~/.claude/rules/gotchas.md` (use ctx_read).

### 3. Find or create the tool group

Scan for an existing `##` heading matching the tool name. If found, append the new entry within that group. If not found, append a new `##` group at the end of the file.

### 4. Format the entry

```
**<what-failed: title-cased, concise>**
<symptom in one line>. <workaround in one line>.
```

Two lines max. No sub-bullets. No verbose explanation.

Example:
```
**patch_vault_file: non-ASCII heading target fails**
`targetType: heading` rejects em dashes or unicode -> `MCP error -32603`. Use `append_to_vault_file` instead.
```

### 5. Write the updated file

Use Write tool to save the updated `gotchas.md`. Confirm to user: "Gotcha added under `## <tool group>`."

## Rules

- Never delete or modify existing entries
- Keep entries to two lines max - if it needs more, it belongs in a decisions doc, not gotchas
- If unsure which tool group to use, ask before writing
- Do not add entries for user code bugs - only tooling/MCP/CLI/API surface failures
