# 10-Inch Unibody Server Rack (6U)

## Overview

A unibody 10-inch server rack designed to print in a single piece on the Bambu Labs H2D 3D printer. The rack prints front-face-down with no support material required. Features include EIA-310-derived mounting holes, rounded exterior edges, and handle cutouts on both sides for portability.

Open-back design provides ventilation and cable management access.

## Dimensions

| Parameter | Value | Description |
|-----------|-------|-------------|
| **Printer Constraints** | | |
| printer_max_x_mm | 325 | H2D build width |
| printer_max_y_mm | 320 | H2D build depth |
| printer_max_z_mm | 325 | H2D build height |
| **10-Inch Rack Standard** | | |
| rack_panel_width_mm | 254.0 | 10" panel width |
| rack_rail_to_rail_center_mm | 236.525 | 9.312" hole center spacing |
| rack_rail_width_mm | 15.875 | 0.625" rail width |
| rack_clear_opening_mm | 222.25 | 8.75" between rail inner edges |
| rack_unit_height_mm | 44.45 | 1U = 1.75" |
| rack_hole_offset_1_mm | 6.35 | 1st hole in U (0.25") |
| rack_hole_offset_2_mm | 22.225 | 2nd hole in U (0.875") |
| rack_hole_offset_3_mm | 38.10 | 3rd hole in U (1.50") |
| **Design Parameters** | | |
| wall_thickness_mm | 5.0 | All walls |
| rack_units | 6 | Number of U |
| rack_depth_mm | 200.0 | Front-to-back depth |
| rail_depth_mm | 15.0 | Mounting rail depth |
| mount_hole_diameter_mm | 6.5 | M6 / #12-24 clearance |
| edge_radius_mm | 8.0 | Outer edge fillet |
| handle_length_mm | 90.0 | Handle slot length (Y) |
| handle_width_mm | 30.0 | Handle slot width (Z) |
| handle_corner_radius_mm | 10.0 | Handle slot corners |
| **Computed** | | |
| rack_height_mm | 266.7 | 6U total height |
| outer_width_mm | 264.0 | Panel + 2x wall |
| outer_height_mm | 276.7 | Rack height + 2x wall |
| inner_corner_radius_mm | 3.0 | edge_radius - wall |

## Component Diagram

### Front View (looking at the rack face, XY plane at Z=0)

```
Y (height)
^
|  +--+--+---------------------------+--+--+
|  |  |  |                           |  |  |  276.7mm
|  |  |  |                           |  |  |
|  |  |oo|                           |oo|  |  <- mounting holes (3 per U)
|  |  |  |                           |  |  |
|  |  |oo|      Clear Opening        |oo|  |
|  |  |  |       222.25mm            |  |  |
|  |  |oo|                           |oo|  |
|  |  |  |                           |  |  |
|  |  |oo|                           |oo|  |
|  |  |  |                           |  |  |
|  |  |oo|                           |oo|  |
|  |  |  |                           |  |  |
|  |  |oo|                           |oo|  |
|  |  |  |                           |  |  |
|  +--+--+---------------------------+--+--+
|  5mm  15.875mm                 15.875mm  5mm
|  wall  rail                     rail    wall
+------------------------------------------------------> X (width)
Origin                                          264mm
```

### Top View (looking down, XZ plane at Y = outer_height/2)

```
Z (depth)
^
|  200mm
|  +-------------------------------------------+
|  |           rack interior                    |  <- open back
|  |                                            |
|  |                                            |
|  |                                            |
|  +====+------------------------------+====+--+
|  |rail|                              |rail|  |  <- rails at front
|  |15mm|                              |15mm|  |
+--+----+------------------------------+----+--+--> X (width)
   5mm                                      5mm
   wall            Z=0 (front/bed)          wall
```

### Side View (looking from right, YZ plane at X = outer_width)

```
Z (depth)                              200mm
^
|  +-------------------------------------------+
|  |                                            |  <- open back
|  |                                            |
|  |            +============+                  |
|  |            |   HANDLE   |  30mm            |
|  |            |   CUTOUT   |                  |
|  |            +============+                  |
|  |                90mm                        |
|  |                                            |
|  +-------------------------------------------+
+--+---------------------------------------------> Y (height)
   Z=0 (front face / build plate)          276.7mm
```

## Components

### outer_shell

- **Purpose**: Main body with rounded vertical edges
- **Position**: Origin [0, 0, 0]
- **Bounding Box**: [0, 0, 0] to [264, 276.7, 200]
- **Notes**: Hull of 4 cylinders (radius 8mm) creates rounded XY cross-section

### inner_cavity

- **Purpose**: Interior void allowing equipment insertion (open front and back)
- **Position**: [5, 5, -1] (extends through both faces)
- **Bounding Box**: [5, 5, -1] to [259, 271.7, 201]
- **Notes**: Inner corner radius 3mm maintains uniform wall thickness at corners

### left_rail / right_rail

- **Purpose**: Mounting surface for rack-mount equipment screws
- **Position Left**: [5, 5, 0] to [20.875, 271.7, 15]
- **Position Right**: [243.125, 5, 0] to [259, 271.7, 15]
- **Notes**: 15mm depth provides adequate screw engagement

### mounting_holes

- **Purpose**: Clearance holes for M6 / #12-24 rack screws
- **Count**: 18 per side (3 holes x 6U), 36 total
- **Left X center**: 13.7375mm from outer left edge
- **Right X center**: 250.2625mm from outer left edge
- **Spacing**: EIA-310 pattern: 15.875, 15.875, 12.70mm repeating

### handle_cutouts

- **Purpose**: Rounded rectangular slots through side walls for carrying
- **Position**: Centered on each side wall (Y and Z centered)
- **Size**: 90mm x 30mm with 10mm corner radius
- **Notes**: Bridges only 5mm (wall thickness) - trivially printable

## Print Settings

- **Orientation**: Front face (Z=0) on build plate
- **Supports**: None required
- **Material**: PLA, PETG, or ASA recommended
- **Infill**: 20-30% (walls are solid at 5mm)
- **Layer height**: 0.2mm recommended
- **Nozzle**: 0.4mm standard
- **Bed adhesion**: Brim recommended for large footprint (264 x 276.7mm)
- **Print time estimate**: 12-20 hours depending on settings

## Post-Processing

- Ream mounting holes to final size if needed (printed holes may be slightly undersized)
- Consider threaded inserts (M6) for repeated screw use
- Light sanding of build plate face for smooth finish

## Changelog

| Date | Change |
|------|--------|
| 2026-04-04 | Initial 6U design - open back, rounded edges, handle cutouts |
