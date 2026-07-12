# Waveshare 7-Inch LCD Case - Portrait

## Overview

Closed two-part enclosure for one portrait Waveshare LCD and a floor-mounted
Raspberry Pi 4/5. The LCD and its M3 hardware are entirely in the removable lid;
the Pi is always behind it on the solid base. Rotating the LCD counter-clockwise
moves its connector edge to the top, so the lid includes a 25.4 mm top service
region while retaining the requested right extension.

All four base walls are continuous except five localized 10 mm cable U-notches.
The default 35-degree angle is parametric and regenerates the base depth and rear
height.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| LCD panel region | 167.88 x 284.40 mm | Portrait cell + right/top service |
| Base print envelope | 167.88 x 232.97 x 218.13 mm | W x table depth x rear height |
| Lid print envelope | 172.68 x 289.20 x 11.70 mm | Separate face-down part |
| LCD angle | 35 degrees | Above tabletop |
| Base front height | 55.00 mm | Electronics clearance |
| Solid floor / walls / lid | 5.00 / 5.00 / 5.00 mm | Full bottom and shell |
| Lid side rails / clearance | 2.00 x 4.00 / 0.40 mm | Rail thickness/depth / per side |
| Right extension | 30.40 mm | 25.40 mm clear + wall |
| Top extension | 30.40 mm | Rotated LCD connector service |
| Cable passages | 5 x 10.00 x 12.00 mm | Count x width x depth |
| Portrait LCD window | 89.00 x 156.00 mm | Rotated existing back opening |
| Source window offset | +1.00 X, +4.00 Y mm | Before rotation |
| LCD PCB/module | 164.90 x 124.27 x 1.60 / 8.30 mm | PCB / total depth |
| Portrait hole pitch/diameter | 114.96 x 156.90 / 3.25 mm | Four M3 holes |
| LCD boss/counterbore | 7.00 x 6.70 / 5.00 x 2.00 mm | Boss / front recess |
| Pi board/hole pitch | 85.00 x 56.00 / 58.00 x 49.00 mm | Pi 4/5 shared pattern |
| Pi standoff/pilot | 7.00 x 9.00 / 2.20 x 7.00 mm | Boss / M2.5 pilot |
| Pi component allowance | 18.00 mm | Above board |
| Printer limit | 325 x 320 x 325 mm | H2D single-nozzle volume |

## Cross-Sections

### Front View - Lid

```text
+---------------------------+  top cable service region
|                           |
|       o +---------+ o     |
|         |         |       |
|         | PORTRAIT|       |
|         |   LCD   |       |
|       o +---------+ o     |
+---------------------------+
       removable LCD lid
```

### Top View - Base With Lid Removed

```text
+===========================+  rear wall
|                           |
|      SOLID BOTTOM         |
|          +-------------+  |
|          | Raspberry Pi|->|  two 10 mm right notches
|          +-------------+  |
+===== U======U======U ======  front cable notches
```

### Side View - Closed

```text
rear 218.13  +-----------------------------+  LCD lid at 35 degrees
             |                            /
             |       Pi behind LCD       /
front 55.00  +--------------------------/
             +==========================+  solid floor
             <---- 232.97 table depth -->
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Solid base | `[0,0,0]` to `[167.88,232.97,218.13]` | Floor-down part |
| Pi bosses | Bottom-right floor, Z `5.00..14.00` | Pi behind portrait lid |
| Continuous walls | Full base perimeter | Sloped cap rim |
| LCD lid | `[0,0,0]` to `[172.68,289.20,11.70]` when printed | Face-down part |
| LCD bosses | Four on lid underside | M3 LCD mounting |
| Cable notches | Three front, two right | 10 mm capped passages |

## Print And Assembly

1. Print the base floor-down and the lid LCD-front-down without supports.
2. Fasten the Pi to the base floor bosses with M2.5 screws.
3. Connect Pi power, video, and USB leads; place only the cable cords into the
   10 mm U-notches before closing the lid.
4. Fasten the portrait LCD to the lid with four M3 screws. Route LCD cables
   through the internal top service region.
5. Rest the lid on the complete rim and press its outside side rails over the
   left/right walls.

See [LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Rebuilt as a closed portrait enclosure with separate lid/base.
