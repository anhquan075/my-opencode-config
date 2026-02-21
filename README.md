# my-opencode-config

Portable OpenCode configuration bundle exported from `~/.config/opencode`.

## Included

- `opencode-config/` - exported config snapshot (`agents`, `commands`, `plugins`, `scripts`, `skills`, and config files)
- `install.sh` - install to `~/.config/opencode` with automatic backup
- `uninstall.sh` - remove installed config (with backup)
- `sync-from-local.sh` - refresh snapshot from your current local `~/.config/opencode`
- `bootstrap-install.sh` - clone + install from a Git repo URL (for another machine)

## Install On This Machine

```bash
bash install.sh
```

## Install On Another Machine (after pushing to GitHub)

1. In OpenCode, type something like:

```text
install this config for https://github.com/anhquan075/my-opencode-config.git
```

This works because the exported config includes `plugins/auto-install-config.ts`,
which auto-detects that phrase and triggers the full install flow.

2. Or directly in shell:

```bash
bash -lc 'tmp=$(mktemp -d) && git clone --depth 1 https://github.com/anhquan075/my-opencode-config.git "$tmp/repo" && bash "$tmp/repo/install.sh"'
```

## Update This Repo Snapshot

```bash
bash sync-from-local.sh
```

## Notes

- Installer backs up existing config to `~/.config/opencode.backup-<timestamp>`.
- `node_modules/` is excluded from exported snapshot for portability.
- Restart OpenCode after install.
