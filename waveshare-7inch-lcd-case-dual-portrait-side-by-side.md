# Waveshare 7-Inch LCD Case - Dual Portrait Side-by-Side

## Overview

Closed enclosure with two portrait LCDs in one removable lid and one Raspberry
Pi 4/5 mounted horizontally to the solid base floor behind them. Both rotated
LCD connector edges face the shared top service region. The base is a complete
tray with only five localized 10 mm cable U-notches.

The default 35-degree LCD plane is adjustable in the SCAD file. Base footprint,
rear wall height, lid border clearance, and closed assembly all update from that
single parameter.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| Two-LCD panel region | 310.36 x 284.40 mm | Two portrait cells + services |
| Base print envelope | 310.36 x 232.97 x 218.13 mm | W x table depth x rear height |
| Lid print envelope | 315.16 x 289.20 x 11.70 mm | Separate face-down part |
| LCD angle | 35 degrees | Above tabletop |
| Base front height | 55.00 mm | Closed electronics clearance |
| Solid floor / walls / lid | 5.00 / 5.00 / 5.00 mm | Complete enclosure surfaces |
| Lid side rails / clearance | 2.00 x 4.00 / 0.40 mm | Rail dimensions / per side |
| Right/top extensions | 30.40 / 30.40 mm | 25.40 mm clear + wall |
| Inter-panel gap | 5.00 mm | Solid lid separator |
| Cable passages | 5 x 10.00 x 12.00 mm | Count x width x depth |
| Each portrait window | 89.00 x 156.00 mm | Rotated existing opening |
| Each LCD PCB/module | 164.90 x 124.27 x 1.60 / 8.30 mm | PCB / total depth |
| Each portrait hole pitch | 114.96 x 156.90 mm | Four 3.25 mm M3 holes |
| LCD boss/counterbore | 7.00 x 6.70 / 5.00 x 2.00 mm | Per-display hardware |
| Pi mounts | 1 | One floor-mounted Pi 4/5 |
| Pi board/hole pitch | 85.00 x 56.00 / 58.00 x 49.00 mm | Shared pattern |
| Pi standoff/pilot | 7.00 x 9.00 / 2.20 x 7.00 mm | Boss / M2.5 pilot |
| Pi component allowance | 18.00 mm | Above board |
| Printer limit | 325 x 320 x 325 mm | Both parts fit H2D |

## Cross-Sections

### Front View - Lid

```text
+--------------------------------------------------+
|          shared top connector service            |
|   o +---------+ o    o +---------+ o             |
|     |portrait |        |portrait |               |
|   o +---------+ o    o +---------+ o             |
+--------------------------------------------------+
              removable dual-LCD lid
```

### Top View - Base With Lid Removed

```text
+==================================================+  rear wall
|                                                  |
|                 SOLID BOTTOM                     |
|                               +---------------+  |
|                               | Raspberry Pi  |->|  10 mm cord notches
|                               +---------------+  |
+========================== U====U====U ============  front wall
```

### Side View - Closed

```text
rear 218.13  +----------------------------------+  35-degree LCD lid
             |                                 /
             |      Pi behind both LCDs       /
front 55.00  +-------------------------------/
             +===============================+  solid floor
             <------- 232.97 table depth ---->
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Solid base | `[0,0,0]` to `[310.36,232.97,218.13]` | One floor-down tray |
| Pi bosses | Bottom-right base floor | One Pi behind both LCDs |
| Base walls | Continuous perimeter | Supports sloped lid |
| Dual lid | `[0,0,0]` to `[315.16,289.20,11.70]` when printed | Holds both LCDs |
| LCD bosses | Eight total on lid underside | Four M3 per display |
| Cable passages | Five 10 mm capped U-notches | Cords installed before lid |

## Print And Assembly

1. Print the solid base floor-down and the dual-LCD lid face-down.
2. Mount one Pi to the base bosses with M2.5 screws.
3. Connect and route cables, laying their cords into the five 10 mm notches.
4. Mount both portrait LCDs to the lid with four M3 fasteners each.
5. Route both LCD cable sets through the shared internal top service region.
6. Rest the lid plate on the complete rim and press its outside side rails over
   the left/right walls.

Use a powered distribution solution sized for two LCDs. See
[LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Rebuilt as a closed dual-portrait enclosure with solid base.
