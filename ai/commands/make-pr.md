# make-pr

## Context inputs (may be present in the command context; do not assume env vars)
- BASE_BRANCH: optional string. If missing/empty, use "main".
- TICKET: optional string like CATINV-1234. If missing/empty, try extracting from current branch name. If still missing, proceed without a ticket prefix.

## Hard rules
- Do NOT switch branches.
- If there are no working-tree changes, skip staging + commit and go straight to PR creation.
- Commit subject style: simple present / imperative verb, no trailing period.
- Do NOT use markdown checkboxes anywhere in the PR body (do not write "- [ ]").
- Keep PR body under 200 words.
- Create a DRAFT PR using gh. If PR creation fails, capture and return the raw output, then suggest next steps.

## GitHub PR template (MUST use this structure; fill sections; leave Demo blank)
Use the following template exactly as a guideline for PR body. Keep headings. Omit sections only if truly empty (except keep Demo heading but leave it blank as instructed).

```md
### What changed?
<!--
Please include a summary of the changes and the related issue.
Please also include relevant motivation and context.
List any dependencies that are required for this change.
-->

### Why did it change?
<!--
Please describe why is this change required? What problem does it solve?
-->

### How is it tested?
<!--
Please describe in detail how to test your changes.
Include details of your testing environment, tests ran to see how
your change affects other areas of the code, etc.
-->

### Demo
<!---
AI AGENTS: LEAVE THIS BLANK FOR ME. I will upload the screenshots/videos.
-->
<!--
|Before|After|
|:-:|:-:|
|Img1|img2|
-->

### Next steps
<!--
This section can often be omitted if we've completed the work. Or just write "None!" if we're done with everything.
Link any tickets or todo items related to this work.
-->
```

# Steps (follow in order; stop on errors)

1) Determine BASE_BRANCH:
- IF BASE_BRANCH exists in command context AND is non-empty, set BASE_BRANCH to that value
- ELSE set BASE_BRANCH = "main"

2) Determine current branch:
- BRANCH = run: git branch --show-current

3) Determine ticket prefix:
- IF TICKET exists in command context AND matches regex [A-Z]+-[0-9]+, set TICKET_FINAL = TICKET
- ELSE extract first match of regex [A-Z]+-[0-9]+ from BRANCH; if found set TICKET_FINAL to that
- ELSE set TICKET_FINAL = "" (empty)

4) Detect changes:
- IF output of: git status --porcelain  is empty:
  - Skip staging + commit
- ELSE:
  - Stage everything: git add -A
  - Generate ONE commit subject in your style:
    - Must start with an imperative verb (Update/Scope/Bump/Refine/Remove/Add/Pass/Simplify/Map/Fix/etc)
    - No trailing period
    - IF TICKET_FINAL is non-empty: "<TICKET_FINAL>: <Verb phrase>"
    - ELSE: "<Verb phrase>"
  - Commit: git commit -m "<subject>"

5) Push branch:
- Run: git push
- IF git push fails due to missing upstream/tracking:
  - Run: git push -u origin HEAD

  DROP-IN EDIT (place right before Step 6 “Create DRAFT PR”)

5.5) Gather context for PR title/body:
- Collect a short summary of commits on this branch relative to BASE_BRANCH:
  - COMMITS = run: git log --oneline "origin/$BASE_BRANCH..HEAD"
  - Use COMMITS to inform the PR title short description and the “What changed?” section (do not paste the whole list; synthesize).
- If TICKET_FINAL is non-empty and additional context would help, fetch the Linear ticket via the Linear MCP using TICKET_FINAL:
  - Pull the ticket title and description
  - Use that to refine the PR body (keep under the 200-word PR limit). DO NOT BE OVERLY VERBOSE. SUCCINCTNESS IS KEY.

6) Create DRAFT PR (do not check for existing PR first):
- Title:
  - IF TICKET_FINAL non-empty: "<TICKET_FINAL>: <Short description>"
  - ELSE: "<Short description>"
- Body:
  - Fill the provided PR template.
  - Under 200 words total.
  - Keep headings.
  - Leave the Demo section blank (do not add text, do not add images, do not add tables).
  - Avoid obvious boilerplate (e.g., do not say "Monitor CI before merging").
  - Aim for 3–5 lines per filled section to stay under the word budget.
- Command (open in browser on success):
  - gh pr create --draft --base "$BASE_BRANCH" --head "$(git branch --show-current)" --title "<title>" --body "<body>" --web

7) If gh pr create fails:
- Print the full stdout/stderr output verbatim.
- Then suggest likely next steps (do not automatically run them):
  - gh auth status
  - gh auth login
  - git remote -v (verify expected repo)
  - confirm permissions to create PRs in the repo
  - retry the same gh pr create command after resolving auth/permissions

8) Final summary (always print):
- Branch name
- Base branch used
- "Commit created: <sha> <subject>" OR "No changes; skipped commit"
- PR URL if created successfully, and confirm it was opened
- If PR failed, state that it failed and reference the captured output
