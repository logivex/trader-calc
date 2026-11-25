# Design system - Logivex

Restrained and typographic. No gradients, no glow, no icon-in-a-rounded-box tiles. Colour appears only
where it means something (profit, loss, caution); everything else is graphite/paper and one accent
(bone in dark, ink in light).

## Colour tokens (`app/lib/theme/tokens.dart`)

| token | dark | light | use |
|---|---|---|---|
| bg | `#0F1114` | `#F4F2EC` | app background |
| surface | `#15181C` | `#FBFAF7` | nav, panels |
| surfaceHigh | `#1C2025` | `#EAE7DF` | inputs |
| outline | `#2A2F36` | `#D8D4C8` | hairlines |
| text / textDim | `#E8E6E1` / `#8B9099` | `#17181A` / `#6A6D74` | copy |
| accent (`acc`) | `#E8E4D8` | `#17181A` | selection, emphasis |
| pos / neg / warn | `#3DDC97` / `#FF5C72` / `#F2B84B` | `#0E8F63` / `#D0334A` / `#A9701A` | meaning only |

The core's `Tone` (`pos|neg|warn|acc|neu`) maps 1:1 via `TraderColors.tone()`.

## Brand

- **Logivex** wordmark: Inter Bold, 13 px, +2.6 letter-spacing, upper case, next to the mark
  (an "L" with a rising price line, `shell/brand.dart`). Replace the painted mark with your own logo
  file when you have one.
- Window / app title: "Logivex Trader Calc".

## Type

- Vazirmatn (Persian + Latin), Inter for the wordmark and figures. Bundled, never fetched at runtime.
- Figures use tabular digits (`numberStyle`) so columns do not jitter while values animate.

## Layout principles

1. **Index, not tiles.** The calculators are a numbered list grouped by the question they answer
   (Position, Risk, Planning, Price levels), separated by hairlines.
2. **One hero figure per result.** Large number, small label; no boxes inside boxes.
3. **Live result, no "Calculate" button.**
4. **Adaptive.** < 840 px: bottom nav. >= 840 px: rail with the brand on top.
5. **RTL first.** Layout mirrors for Persian; numbers stay LTR inside text.
6. **Short motion.** 150-250 ms ease-out; no bounce.

## Next to design (Phase 2)

Number field (`k/m/b` hints, Persian digits), result block with hero figure, verdict line,
Long/Short segmented control, ladder charts, settings sheet.
