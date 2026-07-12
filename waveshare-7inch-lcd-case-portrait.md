# Waveshare 7-Inch LCD Case - Portrait

## Overview

Single-display portrait case made by rotating the compatible 254 x 133.35 mm
panel 90 degrees counter-clockwise. The LCD's physical connector edge therefore
faces the top. A 50.00 mm top extension provides a 45.00 mm clear cable/Pi area,
while the required 25.40 mm clear bay remains on the case right.

`lcd_angle_from_table_deg` is a compile-time parameter. Changing it regenerates
the rear slope and case depth; the default screen angle is 35 degrees above the
tabletop.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| Rotated source feature panel | 133.35 x 254.00 mm | 90 degrees CCW |
| Panel-cell border | 0.96 mm left/right | Gives PCB 0.50 mm wall clearance |
| Case envelope | 165.67 x 304.00 x 254.86 mm | W x H x maximum D at 35 degrees |
| Bottom depth | 42.00 mm | Minimum electronics depth |
| Right extension | 30.40 mm | 25.40 mm clear bay + wall |
| Top extension | 50.00 mm | Rotated LCD cables and Pi footprint |
| Clear top cable chase | 45.00 mm | Outside the source panel boundary |
| LCD angle | 35 degrees | Screen angle above tabletop |
| LCD window | 89.00 x 156.00 mm | Rotated inherited back opening |
| LCD source window/offset | 156.00 x 89.00; +1.00 X/+4.00 Y mm | Before rotation |
| LCD PCB | 164.90 x 124.27 x 1.60 mm | Module total depth 8.30 mm |
| LCD hole pitch | 114.96 x 156.90 mm | Rotated four-hole pattern |
| LCD screw holes | 3.25 mm diameter | M3 clearance |
| LCD boss/counterbore | 7.00 x 6.70 / 5.00 x 2.00 mm | Boss / front recess |
| Pi board pattern | 56.00 x 85.00 mm | Pi 4/5 after CCW rotation |
| Pi source hole pitch/inset | 58.00 x 49.00 / 3.50 mm | Four Pi 4/5 holes |
| Pi edge gap | 2.00 mm | Port edge to inner wall |
| Pi standoff/pilot | 7.00 x 9.00 / 2.20 x 7.00 mm | Boss / blind pilot |
| Pi component allowance | 18.00 mm | Behind board plane Z=14.00 |
| Wall thickness | 5.00 mm | Structural shell |
| Case/feature corner radii | 4.00 / 1.00 mm | Outer / feature radii |
| I/O front lip | 9.00 mm | Solid depth before open notches |
| Pi access margin/height | 4.00 / 72.00 mm | Top/right access sizing |
| LCD source access band | Y=70.00..122.00 mm | 4.00 mm wall-cut margin |
| Inter-panel gap | 5.00 mm | Shared dual-layout parameter |
| Printer limit | 325 x 320 x 325 mm | H2D single-nozzle volume |

Maximum depth is `42 + case_height * tan(angle)`. H2D Z fit limits this layout
to less than 42.95 degrees; the SCAD assertion reports any excessive value.

## Cross-Sections

### Front View (X/Y)

```text
<----- 135.27 cell ------><-30.40->
+---------------------------+--------+  ^
| LCD cable chase       Pi / top I/O |  | 50.00
+---------------------------+--------+  |
|       o +---------+ o     |        |  |
|         |         |       |        |  |
|         |  LCD    |       | right  |  | 254.00
|         |portrait |       | bay    |  |
|       o +---------+ o     |        |  |
+---------------------------+--------+  v
```

### Top View (X/Z)

```text
front Z=0
+------------------------------------+
| bezel       open rear cavity       |
+-----+------------------------+-----+
      sloped table rails at both sides
```

### Side View (Y/Z)

```text
Y=304.00  +--------------------------------------------* Z=254.86
          |                                          /
 portrait |                                        /  rear/table edge
 LCD      |                                      /    35 degrees
Y=0       +--------------- Z=42.00 ------------*
          Z=0
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Face slab | `[0,0,0]` to `[165.67,304.00,5]` | Common front structure |
| Portrait LCD | Source features in rotated cell `[0,0]..[135.27,254]` | Connector edge faces +Y |
| LCD bosses | Four rotated PCB holes, Z `5.00..11.70` | M3 LCD mount |
| Top service area | Y `254.00..304.00` | Cable chase and Pi mount |
| Pi bosses | Upper-right service region, Z `5.00..14.00` | M2.5 Pi mount |
| Rear cheeks | X `0..5` and `160.67..165.67` | Table-contact rails |
| I/O notches | Top/right walls, rear-open from Z=9 | All requested ports |

## Print And Assembly

1. Print front-face-down without supports at 0.20 mm layers; use a brim.
2. Install the LCD from the rear with four M3 fasteners. Its HDMI and micro-USB
   edge points upward after the CCW rotation.
3. Install a Pi 4/5 on the four upper-right bosses with M2.5 self-tapping screws.
4. Route LCD cables through the dedicated top notch. Pi USB/Ethernet exits the
   top; Pi power and micro-HDMI exit the right.
5. Rest the two sloped rear cheek edges on the tabletop.

The open rear preserves cooling, GPIO/microSD access, and support-free printing.
See [LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Initial parametric portrait case.
