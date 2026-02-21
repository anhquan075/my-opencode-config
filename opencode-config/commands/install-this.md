---
description: Install or update OpenCode config from a repo URL
---

Install/update a config bundle from a repository URL.

1. Extract URL from the user's input.
2. If missing, ask for a URL in this format:

```text
install this config for https://github.com/<owner>/<repo>.git
```

3. Run:

```bash
tmp=$(mktemp -d) && git clone --depth 1 <REPO_URL> "$tmp/repo" && bash "$tmp/repo/install.sh"
```

4. Show the install output and remind the user to restart OpenCode.

Notes:
- Default URL (if user says "this config" without URL):
  `https://github.com/anhquan075/my-opencode-config.git`
- Trigger phrase supported by plugin:
  `install this config for <url>`
