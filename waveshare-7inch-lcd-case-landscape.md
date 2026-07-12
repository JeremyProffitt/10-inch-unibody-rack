# Waveshare 7-Inch LCD Case - Landscape

## Overview

Single-display desktop case using the exact LCD opening and four-hole pattern
from `waveshare-7inch-lcd-panel.scad`. The case adds a clear 25.40 mm service
bay beyond the panel's right edge, a Raspberry Pi 4/5 mount, open top/right I/O
notches, and an integral 35-degree wedge stand.

The angle is parametric, not hinged. Change `lcd_angle_from_table_deg` in the
SCAD file and the sloped rear edge and total depth regenerate automatically.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| Source feature panel | 254.00 x 133.35 mm | Existing opening/hole compatibility |
| Panel-cell border | 0.96 mm top/bottom | Gives PCB 0.50 mm wall clearance |
| Case envelope | 297.85 x 135.27 x 136.72 mm | W x H x maximum D at 35 degrees |
| Bottom depth | 42.00 mm | Minimum electronics depth |
| Right extension | 43.85 mm | Full LCD-to-Pi cable corridor plus Pi/wall |
| Clear LCD-to-Pi corridor | 25.40 mm | Unobstructed in the connector Y band |
| LCD angle | 35 degrees | Screen angle above tabletop |
| LCD window, back | 156.00 x 89.00 mm | Existing panel opening |
| LCD window, front | 162.00 x 95.00 mm | 3.00 mm bevel per side |
| LCD window offset | +1.00 X, +4.00 Y mm | Within the source feature panel |
| LCD PCB | 164.90 x 124.27 x 1.60 mm | Module total depth 8.30 mm |
| LCD hole pitch | 156.90 x 114.96 mm | Four 3.25 mm M3 clearance holes |
| LCD boss | 7.00 dia. x 6.70 mm | Four per display |
| LCD screw counterbore | 5.00 dia. x 2.00 mm | Front screw-head recess |
| Pi board pattern | 85.00 x 56.00 mm | Pi 4/5, rotated 90 degrees CCW |
| Pi hole pitch | 58.00 x 49.00 mm | Four 2.20 mm pilot bosses |
| Pi hole inset | 3.50 x 3.50 mm | Source board coordinates |
| Pi edge gap | 2.00 mm | Between port edges and inner walls |
| Pi standoff | 7.00 dia. x 9.00 mm | Board plane at Z=14.00 mm |
| Pi pilot depth | 7.00 mm | 2.20 mm blind holes |
| Pi component allowance | 18.00 mm | Behind the board plane |
| Wall thickness | 5.00 mm | Front, top, bottom, and side cheeks |
| Case/feature corner radii | 4.00 / 1.00 mm | Outer shell / window and boss transitions |
| I/O front lip | 9.00 mm | Solid depth before rear-open notches |
| Pi access margin/height | 4.00 / 72.00 mm | Broad top/right port notches |
| LCD access band | Y=70.00..122.00 mm | Expanded 4.00 mm each end in wall cutout |
| Printer limit | 325 x 320 x 325 mm | H2D single-nozzle volume |

Maximum depth is `42 + case_height * tan(lcd_angle_from_table_deg)`. At this
layout's height the H2D Z limit permits angles below 64.45 degrees; the model's
general validation range is 15 to less than 60 degrees.

## Cross-Sections

### Front View (X/Y)

```text
<---------------- 254.00 panel ----------------><---43.85--->
+------------------------------------------------+--------+  ^
|     o +------------------------------+ o       |        |  |
|       |        LCD 156 x 89          |         | Pi /   |  | 135.27
|     o +------------------------------+ o       | cables |  |
+------------------------------------------------+--------+  v
                                                   right I/O
```

### Top View (X/Z)

```text
front / build plate Z=0
+---------------------------------------------------------+
| bezel             open electronics cavity               |
+-----+---------------------------------------------+-----+
      left cheek                             right cheek
      <-------------- open rear ------------------->
```

### Side View (Y/Z)

```text
Y=135.27  +--------------------------------------* Z=136.72
          |                                    /
  LCD     |                                  /  rear/table edge
  plane   |                                /    (35 degrees)
Y=0       +------------- Z=42.00 --------*
          Z=0
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Face slab | `[0,0,0]` to `[297.85,135.27,5]` | Supports LCD and Pi bosses |
| LCD opening | Source-panel offset `50.00,26.175`, then +0.96 Y | Exact inherited feature placement |
| LCD bosses | Four source-panel PCB holes, Z `5.00..11.70` | LCD mounts from rear |
| Pi bosses | Upper-right solid service area, Z `5.00..14.00` | Pi mounts from open rear |
| Side cheeks | First/last 5.00 mm of X | Sloped rear edges support case |
| Connector notches | Right and top walls, Z `9.00..rear` | LCD, USB, power, video access |

## Print And Assembly

1. Print front-face-down at Z=0 with no supports, 0.20 mm layers, and a brim.
2. Place the LCD against the bezel from the rear and fasten its four holes with
   M3 hardware. Check screw length against the physical LCD revision.
3. Place a Pi 4/5 on the four service-bay bosses and use M2.5 self-tapping
   screws in the 2.20 mm pilot holes.
4. Route LCD HDMI/micro-USB through the right notch. Route Pi USB/Ethernet
   through the top notch and Pi USB-C/micro-HDMI through the right notch.
5. Place the two sloped rear cheek edges on the tabletop. Use non-slip pads if
   the table surface is smooth.

The rear stays open for cooling, GPIO/microSD access, cable installation, and
support-free printing. See [LCD hardware reference](waveshare-7inch-lcd-display-b.md)
and [Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Initial parametric landscape case.
