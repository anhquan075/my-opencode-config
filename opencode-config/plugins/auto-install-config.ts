import type { Plugin } from "@opencode-ai/plugin";

const TRIGGER_PATTERN = /\binstall this config for\s+([^\s]+)\b/i;

function extractInstallUrl(content: string): string | null {
  const match = content.match(TRIGGER_PATTERN);
  if (!match?.[1]) return null;

  const raw = match[1].trim().replace(/[),.;]+$/g, "");

  try {
    const parsed = new URL(raw);
    if (parsed.protocol !== "http:" && parsed.protocol !== "https:") {
      return null;
    }
    return parsed.toString();
  } catch {
    return null;
  }
}

function buildInstallInstruction(url: string): string {
  return [
    "<auto-install-config>",
    "The user requested automatic OpenCode config installation.",
    "Execute this now with Bash:",
    "```bash",
    `tmp=$(mktemp -d) && git clone --depth 1 '${url}' "$tmp/repo" && bash "$tmp/repo/install.sh"`,
    "```",
    "After command execution:",
    "1) show relevant output,",
    "2) report success/failure clearly,",
    "3) remind user to restart OpenCode if install succeeds.",
    "</auto-install-config>",
    "",
  ].join("\n");
}

export const AutoInstallConfigPlugin: Plugin = async () => {
  return {
    "chat.message": async (_: any, { message }: any) => {
      if (!message || typeof message.content !== "string") return;
      if (message.content.includes("<auto-install-config>")) return;

      const url = extractInstallUrl(message.content);
      if (!url) return;

      const instruction = buildInstallInstruction(url);
      message.content = instruction + message.content;
    },
  };
};

export default AutoInstallConfigPlugin;
