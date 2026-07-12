# Waveshare 7-Inch LCD Case - Dual Landscape Stacked

## Overview

Two compatible source panels stacked vertically with a 5.00 mm separator band.
Both LCD connector edges feed a common right service bay. One Raspberry Pi 4/5
mount is provided for a dual-display Pi; each LCD retains independent HDMI and
power/touch cable access.

The screen plane defaults to 35 degrees above the tabletop. Change
`lcd_angle_from_table_deg` and the rear slope and depth update automatically.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| Two-panel content | 254.00 x 275.54 mm | 2 x 135.27 mm cells + 5.00 mm gap |
| Per-cell border | 0.96 mm top/bottom | Gives each PCB 0.50 mm wall clearance |
| Case envelope | 297.85 x 275.54 x 234.94 mm | W x H x maximum D at 35 degrees |
| Bottom depth | 42.00 mm | Minimum electronics depth |
| Right extension | 43.85 mm | LCD corridor, Pi footprint, gap, and wall |
| Clear LCD-to-Pi corridor | 25.40 mm | Unobstructed for each LCD connector band |
| LCD angle | 35 degrees | Screen angle above tabletop |
| Each LCD window | 156.00 x 89.00 mm | Exact inherited opening |
| LCD window offset | +1.00 X, +4.00 Y mm | Within each source feature panel |
| Each LCD PCB | 164.90 x 124.27 x 1.60 mm | Module total depth 8.30 mm |
| Each LCD hole pitch | 156.90 x 114.96 mm | Four M3 holes per LCD |
| LCD screw/boss/counterbore | 3.25 / 7.00 x 6.70 / 5.00 x 2.00 mm | Hole / boss / recess |
| Pi mounts | 1 | Shared Pi 4/5 footprint |
| Pi board/hole pitch | 85.00 x 56.00 / 58.00 x 49.00 mm | Rotated board / source pitch |
| Pi hole inset/edge gap | 3.50 / 2.00 mm | Mount and port clearances |
| Pi standoff/pilot | 7.00 x 9.00 / 2.20 x 7.00 mm | Boss / blind pilot |
| Pi component allowance | 18.00 mm | Behind board plane Z=14.00 |
| Wall thickness | 5.00 mm | Structural shell and separator |
| Case/feature corner radii | 4.00 / 1.00 mm | Outer / feature radii |
| I/O front lip | 9.00 mm | Solid depth before open notches |
| Pi access margin/height | 4.00 / 72.00 mm | Top/right access sizing |
| LCD source access band | Y=70.00..122.00 mm | 4.00 mm wall-cut margin |
| Inter-panel gap | 5.00 mm | Solid separator band |
| Printer limit | 325 x 320 x 325 mm | H2D single-nozzle volume |

Maximum depth is `42 + case_height * tan(angle)`. H2D Z fit limits this layout
to less than 45.77 degrees; the SCAD assertion reports an excessive value.

## Cross-Sections

### Front View (X/Y)

```text
<---------------- 254.00 ----------------><---43.85--->
+------------------------------------------+--------+  ^
|     o +--------------------------+ o     | Pi /   |  |
|       |       upper LCD          |       | cables |  | 135.27
|     o +--------------------------+ o     |        |  |
+------------------------------------------+--------+  | 5.00
|     o +--------------------------+ o     |        |  |
|       |       lower LCD          |       | right  |  | 135.27
|     o +--------------------------+ o     | bay    |  |
+------------------------------------------+--------+  v
```

### Top View (X/Z)

```text
front Z=0
+---------------------------------------------------------+
| stacked-display bezel       open rear cavity            |
+-----+---------------------------------------------+-----+
      left rail                             right/I-O rail
```

### Side View (Y/Z)

```text
Y=275.54  +-----------------------------------------* Z=234.94
          |                                       /
 upper    |                                     /
 -------- |                                   /  35-degree rear/table edge
 lower    |                                 /
Y=0       +-------------- Z=42.00 --------*
          Z=0
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Face slab | `[0,0,0]` to `[297.85,275.54,5]` | Unifies both display cells |
| Lower LCD | Cell Y `0..135.27` | Connector edge faces right |
| Upper LCD | Cell Y `140.27..275.54` | Connector edge faces right |
| LCD bosses | Eight total, Z `5.00..11.70` | Four M3 mounts per LCD |
| Right service bay | X `254.00..297.85` | Clear LCD corridors plus Pi and wall |
| Pi bosses | Upper-right solid region, Z `5.00..14.00` | One Pi 4/5 |
| Rear cheeks | First/last 5.00 mm of X | Table-contact rails |

## Print And Assembly

1. Print front-face-down without supports at 0.20 mm layers; use a brim for the
   297.85 x 275.54 mm build-plate footprint.
2. Install both landscape LCDs from the rear with four M3 fasteners each.
3. Install one Pi 4/5 on the upper-right bosses with M2.5 self-tapping screws.
4. Route each LCD's HDMI and micro-USB through its own right-wall notch. Use an
   appropriate powered distribution solution for the two displays.
5. Route Pi USB/Ethernet through the top and Pi power/video through the right.
6. Rest both rear cheek edges on the tabletop and add non-slip pads as needed.

See [LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Initial dual landscape vertically stacked case.
