# Waveshare 7-Inch LCD Case - Dual Portrait Side-by-Side

## Overview

Two compatible source panels rotated 90 degrees counter-clockwise and placed
side by side with a 5.00 mm divider band. Both LCD connector edges face a common
top cable chase. The case provides one Raspberry Pi 4/5 mount; a Pi with two
micro-HDMI outputs can drive the two displays, while each LCD still needs its
own power/touch cable.

The default panel angle is 35 degrees above the tabletop. Editing
`lcd_angle_from_table_deg` regenerates the rear slope and total depth.

## Dimensions

| Parameter | Default | Notes |
|---|---:|---|
| Two-panel content | 275.54 x 254.00 mm | 2 x 135.27 mm cells + 5.00 mm gap |
| Per-cell border | 0.96 mm left/right | Gives each PCB 0.50 mm wall clearance |
| Case envelope | 305.94 x 304.00 x 254.86 mm | W x H x maximum D at 35 degrees |
| Bottom depth | 42.00 mm | Minimum electronics depth |
| Right extension | 30.40 mm | 25.40 mm clear bay + wall |
| Top extension | 50.00 mm | Common cable/Pi service region |
| Clear top cable chase | 45.00 mm | Outside source-panel height |
| LCD angle | 35 degrees | Screen angle above tabletop |
| Each LCD window | 89.00 x 156.00 mm | Rotated inherited opening |
| LCD source window/offset | 156.00 x 89.00; +1.00 X/+4.00 Y mm | Before rotation |
| Each LCD PCB | 164.90 x 124.27 x 1.60 mm | Module total depth 8.30 mm |
| Each LCD hole pitch | 114.96 x 156.90 mm | Four M3 holes per LCD |
| LCD screw/boss/counterbore | 3.25 / 7.00 x 6.70 / 5.00 x 2.00 mm | Hole / boss / recess |
| Pi mounts | 1 | Shared Pi 4/5 footprint |
| Pi board/hole pitch | 85.00 x 56.00 / 58.00 x 49.00 mm | Rotated board / source pitch |
| Pi hole inset/edge gap | 3.50 / 2.00 mm | Mount and port clearances |
| Pi standoff/pilot | 7.00 x 9.00 / 2.20 x 7.00 mm | Boss / blind pilot |
| Pi component allowance | 18.00 mm | Behind board plane Z=14.00 |
| Wall thickness | 5.00 mm | Structural shell and divider band |
| Case/feature corner radii | 4.00 / 1.00 mm | Outer / feature radii |
| I/O front lip | 9.00 mm | Solid depth before open notches |
| Pi access margin/height | 4.00 / 72.00 mm | Top/right access sizing |
| LCD source access band | Y=70.00..122.00 mm | 4.00 mm wall-cut margin |
| Inter-panel gap | 5.00 mm | Solid separator band |
| Printer limit | 325 x 320 x 325 mm | H2D single-nozzle volume |

Maximum depth is `42 + case_height * tan(angle)`. H2D Z fit limits this layout
to less than 42.95 degrees. Width and height remain within 325 x 320 mm.

## Cross-Sections

### Front View (X/Y)

```text
<--135.27--><5><--135.27--><-30.40->
+-----------+---+-----------+--------+  ^
| LCD cable chase        Pi / top I/O |  | 50.00
+-----------+---+-----------+--------+  |
|  +-----+  |   |  +-----+  |        |  |
|  | LCD |  |   |  | LCD |  | right  |  | 254.00
|  |  P  |  |   |  |  P  |  | bay    |  |
|  +-----+  |   |  +-----+  |        |  |
+-----------+---+-----------+--------+  v
```

### Top View (X/Z)

```text
front Z=0
+----------------------------------------------------------------+
| two-display bezel             open rear cavity                  |
+-----+----------------------------------------------------+-----+
      left rail                                      right rail
```

### Side View (Y/Z)

```text
Y=304.00  +--------------------------------------------* Z=254.86
          |                                          /
  LCDs    |                                        /  shared 35-degree
          |                                      /    table-contact edge
Y=0       +--------------- Z=42.00 ------------*
          Z=0
```

## Components

| Component | Position / Bounding Box | Connection |
|---|---|---|
| Face slab | `[0,0,0]` to `[305.94,304.00,5]` | Unifies both display cells |
| Left LCD cell | X `0..135.27`, Y `0..254` | Connector edge faces top |
| Right LCD cell | X `140.27..275.54`, Y `0..254` | Connector edge faces top |
| LCD bosses | Eight total, Z `5.00..11.70` | Four M3 mounts per LCD |
| Common top chase | Y `254.00..304.00` | Two LCD cable notches + Pi |
| Pi bosses | Upper-right solid region, Z `5.00..14.00` | One Pi 4/5 |
| Rear cheeks | First/last 5.00 mm of X | Wide table-contact stance |

## Print And Assembly

1. Print front-face-down without supports, preferably with a brim.
2. Install both portrait LCDs from the rear using four M3 fasteners each.
3. Install one Pi 4/5 on the upper-right bosses with M2.5 self-tapping screws.
4. Route both LCD HDMI and power/touch leads through their top notches. Use a
   powered distribution solution appropriate for two displays rather than
   assuming the Pi can supply both from its USB ports.
5. Route Pi USB/Ethernet upward and Pi power/video through the right notch.
6. Rest the sloped rear cheek edges on the tabletop and add non-slip pads.

See [LCD hardware reference](waveshare-7inch-lcd-display-b.md) and
[Pi mechanical reference](raspberry-pi-4-5-mechanical-reference.md).

## Changelog

- 2026-07-12: Initial dual portrait side-by-side case.
