# Waveshare 7-Inch LCD Case - Dual Landscape Stacked

## Overview

Closed enclosure with two landscape LCDs stacked vertically in a removable lid.
One Raspberry Pi 4/5 mounts to the solid floor behind the lid. Both LCDs retain
their right-side internal connector clearance; cables leave through small 10 mm
U-notches rather than open wall sections.

The closed LCD plane defaults to 35 degrees above the table. Editing the angle
regenerates the base footprint, rear height, and lid-to-wall clearance.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| Two-LCD panel region | 284.40 x 279.96 mm | Stacked cells + right service |
| Base print envelope | 284.40 x 229.33 x 215.58 mm | W x table depth x rear height |
| Lid print envelope | 289.20 x 284.76 x 11.70 mm | Separate face-down part |
| LCD angle | 35 degrees | Above tabletop |
| Base front height | 55.00 mm | Closed electronics clearance |
| Solid floor / walls / lid | 5.00 / 5.00 / 5.00 mm | Complete enclosure surfaces |
| Lid side rails / clearance | 2.00 x 4.00 / 0.40 mm | Rail dimensions / per side |
| Right extension | 30.40 mm | 25.40 mm clear + wall |
| Inter-panel gap | 5.00 mm | Solid lid separator |
| Cable passages | 5 x 10.00 x 12.00 mm | Count x width x depth |
| Each landscape window | 156.00 x 89.00 mm | Existing opening |
| Each LCD PCB/module | 164.90 x 124.27 x 1.60 / 8.30 mm | PCB / total depth |
| Each hole pitch/diameter | 156.90 x 114.96 / 3.25 mm | Four M3 holes |
| LCD boss/counterbore | 7.00 x 6.70 / 5.00 x 2.00 mm | Per-display hardware |
| Pi mounts | 1 | One floor-mounted Pi 4/5 |
| Pi board/hole pitch | 85.00 x 56.00 / 58.00 x 49.00 mm | Shared pattern |
| Pi standoff/pilot | 7.00 x 9.00 / 2.20 x 7.00 mm | Boss / M2.5 pilot |
| Pi component allowance | 18.00 mm | Above board |
| Printer limit | 325 x 320 x 325 mm | Both parts fit H2D |

## Cross-Sections

### Front View - Lid

```text
+---------------------------------------------+
|    o +---------------------------+ o        |
|      |       upper LCD           |          |
|    o +---------------------------+ o        |
|                                             |
|    o +---------------------------+ o        |
|      |       lower LCD           |          |
|    o +---------------------------+ o        |
+---------------------------------------------+
```

### Top View - Base With Lid Removed

```text
+=============================================+  rear wall
|                                             |
|                SOLID BOTTOM                 |
|                            +--------------+ |
|                            | Raspberry Pi |>|  two right notches
|                            +--------------+ |
+======================= U====U====U ==========  front wall
```

### Side View - Closed

```text
rear 215.58  +--------------------------------+  stacked LCD lid
             |                               /
             |      Pi behind LCDs          /  35 degrees
front 55.00  +-----------------------------/
             +=============================+  solid floor
             <------ 229.33 table depth --->
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Solid base | `[0,0,0]` to `[284.40,229.33,215.58]` | Floor-down closed tray |
| Pi bosses | Bottom-right base floor | Pi behind both LCDs |
| Continuous walls | Full base perimeter | Sloped lid support |
| Stacked lid | `[0,0,0]` to `[289.20,284.76,11.70]` when printed | Holds both LCDs |
| LCD bosses | Eight on lid underside | Four M3 per display |
| Cable passages | Five 10 mm capped U-notches | No broad wall cutouts |

## Print And Assembly

1. Print the base on its solid floor and the lid LCD-front-down.
2. Mount one Pi to the floor bosses with M2.5 screws.
3. Plug in Pi cables and lay their cords into the 10 mm wall notches.
4. Install both landscape LCDs in the lid with four M3 fasteners each.
5. Route the LCD connectors inside the right service region, rest the lid plate
   on the complete rim, and press its outside rails over the side walls.

Use a powered distribution solution sized for two LCDs. See
[LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Rebuilt as a closed stacked enclosure with solid base and lid.
