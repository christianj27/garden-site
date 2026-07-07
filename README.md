# 🌱 Garden Site — Quartz Config & Customizations

This repo contains the **Quartz v5** static site generator configuration and customizations for **[garden.christianjeremia.com](https://garden.christianjeremia.com)**.

## What's Here

| Path | Purpose |
|------|---------|
| `quartz.config.yaml` | Site config — page title, theme, plugins, base URL |
| `quartz/components/Head.tsx` | Customized HTML head component (meta title override for home page) |
| `public/` | Built static site output (served by nginx) |
| `content/` | Symlink or reference to the Obsidian vault |
| `quartz/` | Quartz source (components, plugins, build pipeline) |

## Key Customizations

1. **`Head.tsx`** — Modified so the home page (`/notes/index`) uses `🧠 Second Brain — Digital Garden` as the HTML `<title>` instead of the folder name, while other pages get `[Title] | 🧠 Second Brain — Digital Garden`
2. **`quartz.config.yaml`** — `article-title` plugin disabled (notes already have H1s), `pageTitleSuffix` set for consistent branding, `baseUrl` set to the live domain

## Tech Stack

```
Obsidian Vault (markdown)
    ↓ Git push
GitHub (second-brain repo)
    ↓ VPS pull + build
Quartz (this repo) → nginx → Caddy → Cloudflare
    ↓
garden.christianjeremia.com
```

## Related

- **[github.com/christianj27/second-brain](https://github.com/christianj27/second-brain)** — The Obsidian vault (raw markdown notes)
- **[garden.christianjeremia.com](https://garden.christianjeremia.com)** — The live site

---

*Everything here is a work in progress — like any good garden* 🌱
