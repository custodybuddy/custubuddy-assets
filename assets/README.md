# CustodyBuddy runtime assets

This directory contains only render-ready assets loaded by Remotion through
`staticFile()`. Shared brand media belongs in `brand/`; campaign-specific media
belongs in `compositions/<composition-id>/`.

## Naming and replacement rules

- Use lowercase kebab-case names. Number ordered media with two digits.
- Do not use spaces, dates, tool-generated names, or suffixes such as `final`.
- Preserve the documented pixel dimensions and aspect ratio when replacing an
  asset. Never stretch a logo, screenshot, slide, or device mockup.
- Add every runtime asset to `src/assets.ts`, then run `npm run assets:check`.
- Optional voiceovers use
  `compositions/<composition-id>/audio/voiceover-<locale>.mp3`. Do not add an
  empty audio directory or placeholder file.

## Inventory and provenance

| Asset group             | Dimensions / format        | Source and intended use                                                                                                                                       |
| ----------------------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dark wordmark           | 600×150 transparent PNG    | Original approved `CustodyBuddy.com` wordmark for dark surfaces.                                                                                              |
| Light wordmark          | 600×150 transparent PNG    | Deterministic Space Void recolor of the approved wordmark; no gold text on light surfaces.                                                                    |
| Monograms               | 1024×1024 transparent PNG  | `C` and `B` letterforms extracted from the approved wordmark with 12% minimum safe padding; square icon placements only.                                      |
| Background overlays     | 1080×1920 alpha WebP       | AI-generated texture sources, normalized to the locked Space Void, Celestial Gold, and light-paper palette. Layer over code-driven solid colors or gradients. |
| Utility icons           | 24×24 SVG viewBox          | Project-authored shield, lock, success, and information glyphs using locked status colors.                                                                    |
| Lora fonts              | WOFF2                      | Official Google Fonts Lora files under the included SIL Open Font License. Use for headings.                                                                  |
| UI tones                | 44.1 kHz, mono, 16-bit WAV | Deterministic sine tones migrated from the original composition code.                                                                                         |
| Landing-page hero files | PNG                         | Full-layout and transparent marketing hero exports. Reusable on CustodyBuddy landing and campaign pages.                                                       |
| Email automation slides | 941×1672 PNG               | Original five exports moved without recompression. Use only in the co-parent email automation composition.                                                    |

The three generated background prompts requested: subtle Space Void film grain,
a restrained Celestial Gold atmospheric glow on a removable chroma-key field,
and subtle warm light-paper grain. All prompts prohibited text, logos, objects,
watermarks, strong contrast, and obvious focal elements.
