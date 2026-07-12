# Waveshare 7-Inch LCD Case - Landscape

## Overview

Closed two-part enclosure for one landscape Waveshare LCD and one Raspberry Pi
4/5. The removable lid contains the LCD opening, M3 holes, and mounting bosses.
The Pi mounts horizontally to bosses on the solid base floor, behind the LCD.

The base has four continuous walls. Three 10 mm front notches and two 10 mm
right notches carry cable cords; the lid plate caps the front notches and the
right locator rail has matching reliefs.
There are no broad wall openings. The default LCD angle is 35 degrees above the
table, and changing `lcd_angle_from_table_deg` recalculates the base footprint,
rear height, and LCD-to-wall clearance.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| LCD panel region | 284.40 x 137.48 mm | Includes right connector extension |
| Base print envelope | 284.40 x 112.62 x 133.85 mm | W x table depth x rear height |
| Lid print envelope | 289.20 x 142.28 x 11.70 mm | Separate face-down part |
| LCD angle | 35 degrees | Above tabletop |
| Base front height | 55.00 mm | Minimum closed electronics depth |
| Solid floor | 5.00 mm | Full base footprint |
| Wall thickness | 5.00 mm | Four continuous walls |
| Lid thickness | 5.00 mm | LCD faceplate |
| Lid side rails | 2.00 x 4.00 mm | Thickness x depth outside side walls |
| Lid fit clearance | 0.40 mm per side | Removable outside cap |
| Right extension | 30.40 mm | 25.40 mm clear + 5.00 mm wall |
| Cable passages | 5 x 10.00 mm | Three front, two right U-notches |
| Cable notch depth | 12.00 mm | Open at base rim; capped by lid |
| LCD window, back/front | 156.00 x 89.00 / 162.00 x 95.00 mm | Existing opening + bevel |
| LCD window offset | +1.00 X, +4.00 Y mm | Source panel coordinates |
| LCD PCB/module | 164.90 x 124.27 x 1.60 / 8.30 mm | PCB / total depth |
| LCD hole pitch/diameter | 156.90 x 114.96 / 3.25 mm | Four M3 holes |
| LCD boss | 7.00 x 6.70 mm | Diameter x length |
| LCD counterbore | 5.00 x 2.00 mm | Diameter x depth |
| Pi board/hole pitch | 85.00 x 56.00 / 58.00 x 49.00 mm | Pi 4/5 shared pattern |
| Pi standoff | 7.00 x 9.00 mm | Diameter x height on floor |
| Pi pilot hole | 2.20 x 7.00 mm | M2.5 self-tapping pilot |
| Pi component allowance | 18.00 mm | Above board |
| Printer limit | 325 x 320 x 325 mm | H2D single-nozzle volume |

## Cross-Sections

### Front View - Lid

```text
<--------------------- 289.20 --------------------->
+---------------------------------------------------+
|          o +-------------------------+ o          |
|            |     LANDSCAPE LCD       |            |
|          o +-------------------------+ o          |
+---------------------------------------------------+
       removable lid; LCD hardware on underside
```

### Top View - Base With Lid Removed

```text
+===================================================+  rear wall
|                                                   |
|             SOLID BOTTOM FLOOR                    |
|                                  +-------------+  |
|                                  | Raspberry Pi|->|  two 10 mm right notches
|                                  +-------------+  |
+============================= U==U==U ==============  front wall
                              power / video cords
```

### Side View - Closed

```text
                      lid / LCD plane (35 degrees)
rear 133.85  +-----------------------------------+
             |                                  /
             |       Pi behind LCD             /
front 55.00  +--------------------------------/
             +================================+  solid 5 mm floor
             <--------- 112.62 table depth -->
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Solid base | `[0,0,0]` to `[284.40,112.62,133.85]` | Floor-down printable part |
| Pi bosses | Bottom-right floor region, Z `5.00..14.00` | Pi lies flat behind LCD |
| Base walls | Complete footprint perimeter | Sloped top receives lid |
| Lid | `[0,0,0]` to `[289.20,142.28,11.70]` in print orientation | Plate plus outside side rails |
| LCD bosses | Lid underside, Z `5.00..11.70` in print orientation | Four M3 mounts |
| Cable passages | Three front and two right 10 mm U-notches | Cord drops in before lid |

## Print And Assembly

1. Export and print `-base.stl` floor-down without supports.
2. Export and print `-lid.stl` LCD-front-down without supports.
3. Mount the Pi to the base bosses with M2.5 self-tapping screws.
4. Plug cables into the Pi, then drop their cords into the 10 mm U-notches.
   Plug shells remain inside and do not need to pass through the openings.
5. Mount the LCD to the lid with four M3 fasteners and route its right-edge
   HDMI and micro-USB leads inside the 25.4 mm service region.
6. Rest the lid plate on the complete wall rim and press its two outside side
   rails over the left/right walls.

See [LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Rebuilt as a closed solid-bottom base with removable LCD lid.
