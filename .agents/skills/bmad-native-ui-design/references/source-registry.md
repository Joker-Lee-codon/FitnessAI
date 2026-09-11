# Source registry

Use upstream material selectively and keep native Apple rules authoritative for production UI.

| Source | Role in this workflow | License | Upstream |
|---|---|---|---|
| UI/UX Pro Max | One-time design-system candidates and SwiftUI stack rules in ND-02 | MIT | https://github.com/nextlevelbuilder/ui-ux-pro-max-skill |
| Anthropic Frontend Design | Distilled direction-setting and anti-template principles in ND-01; no Web implementation assumptions | Apache-2.0 | https://github.com/anthropics/skills/tree/main/skills/frontend-design |
| Impeccable | Optional named critique, harden, or polish pass only | Apache-2.0 | https://github.com/pbakaus/impeccable |
| Vercel Web Interface Guidelines | Optional HTML presentation review only; never a native gate | MIT | https://github.com/vercel-labs/web-interface-guidelines |
| Apple Human Interface Guidelines | Mandatory native behavior and platform-quality reference | Apple documentation terms | https://developer.apple.com/design/human-interface-guidelines/ |

Do not load or execute Tailwind patterns for SwiftUI deliverables. Pin upstream versions before vendoring any source; preserve license and attribution notices for copied or modified material.

