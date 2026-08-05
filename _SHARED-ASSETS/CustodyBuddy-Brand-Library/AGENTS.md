# Agent Instructions & Brand Rules: CustodyBuddy

This document contains mandatory guidelines for AI coding agents (Codex, Claude, ChatGPT, etc.) and human developers working with CustodyBuddy assets and codebases.

## Mandatory Brand Rules

1. **Background Palette:**
   - CustodyBuddy backgrounds MUST remain dark navy or near-black (`#0B0E14` / `#0D111A` / Space Void).
   - Use subtle blue gradients and softly blended blue haze.
   - NEVER use gold as a background gradient, large glow, or background haze.

2. **Gold Usage Rules:**
   - Celestial Gold (`#E6C280` / `#D4AF37`) is strictly reserved for borders, titles, icons, lines, logos, and small accent details.
   - Do not fill large surfaces or background fields with gold.

3. **Product Accuracy & Realism:**
   - Preserve the real CustodyBuddy interface at all times.
   - Do NOT invent fictional product fields, UI buttons, legal features, report forms, testimonials, or claims.

4. **Typography & Layout:**
   - Keep typography readable and accessible.
   - Headings use approved Lora serif styling; body copy uses clean sans-serif typography.
   - Prefer high contrast and uncluttered layouts.

5. **Asset Integrity & Transparency:**
   - Preserve transparent PNG/WebP/SVG backgrounds whenever available.
   - Do NOT permanently flatten reusable assets onto a background unless the file is explicitly an approved final export.

## Asset Library Operations

- Read `README.md` and `asset-manifest.json` before requesting or adding assets.
- Do NOT delete, rename, or overwrite existing source assets in external project folders.
- Always copy approved assets into local project folders using `scripts/copy-assets-to-project.sh`.
