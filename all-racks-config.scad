/**
 * Shared Configuration and Modules for All Rack Designs
 *
 * Coordinate System (print orientation):
 *   X = Rack width  (positive = right when facing rack front)
 *   Y = Rack height (positive = up in use orientation; along bed Y in print)
 *   Z = Rack depth  (positive = toward back; upward in print orientation)
 *
 * Origin: Front-bottom-left corner of rack outer shell
 *
 * Print Orientation:
 *   Front face (Z=0) placed on build plate.
 *   All walls are vertical in print - zero supports required.
 *   Nut pocket bevels are self-supporting (pointed ceiling).
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 */

// =========================================
// DIMENSIONS (all values in millimeters)
// =========================================

// --- Printer Constraints (Bambu Labs H2D, single nozzle) ---
printer_max_x_mm = 325;
printer_max_y_mm = 320;
printer_max_z_mm = 325;

// --- 10-Inch Rack Standard (derived from IEC 60297 / EIA-310) ---
rack_panel_width_mm         = 254.0;     // 10" = total front panel width
rack_rail_to_rail_center_mm = 236.525;   // 9.312" mounting hole center-to-center
rack_rail_width_mm          = 15.875;    // 0.625" width of each mounting rail
rack_clear_opening_mm       = 222.25;    // 8.75" clear space between rail inner edges
rack_unit_height_mm         = 44.45;     // 1U = 1.75"

// Vertical hole pattern within each U (measured from bottom of each U)
rack_hole_offset_1_mm = 6.35;           // 0.25"
rack_hole_offset_2_mm = 22.225;         // 0.875"
rack_hole_offset_3_mm = 38.10;          // 1.50"

// --- Design Parameters ---
wall_thickness_mm      = 5.0;           // Wall thickness on all sides
rack_units             = 6;             // Number of rack units
rack_depth_mm          = 200.0;         // Total front-to-back depth
rail_depth_mm          = 25.0;          // How far mounting rails extend from front face
rail_margin_mm         = 16.65;         // Extra space above/below mounting holes
rail_bevel_mm          = rack_rail_width_mm; // 45-degree bevel full rail width on inner edge
mount_hole_diameter_mm = 6.5;           // Clearance hole for M6 / #12-24 screws
edge_radius_mm         = 8.0;           // Fillet radius on outer vertical edges

// --- M6 Nut Trap Parameters ---
enable_nut_traps        = true;         // Set false for simple through-holes only
nut_across_flats_mm     = 10.0;         // M6 hex nut across flats
nut_thickness_mm        = 5.0;          // M6 hex nut thickness
nut_tolerance_mm        = 0.3;          // Print clearance tolerance
nut_pocket_af_mm        = nut_across_flats_mm + nut_tolerance_mm;   // 10.3mm
nut_pocket_depth_mm     = nut_thickness_mm + nut_tolerance_mm;       // 5.3mm
nut_hex_od_mm           = nut_pocket_af_mm / cos(30);                // ~11.9mm across corners
nut_bevel_height_mm     = 1.0;          // V bevel height for printability
nut_z_start_mm          = 6.0;                                       // 6mm behind front face of rail
nut_slot_width_mm       = nut_pocket_af_mm;                          // 10.3mm

// Back rail nut trap Z position (mirrored from front)
back_rail_z_start_mm    = rack_depth_mm - rail_depth_mm;             // Where back rail begins
back_nut_z_start_mm     = rack_depth_mm - nut_z_start_mm - nut_pocket_depth_mm; // Mirrored pocket start

// --- Handle Cutouts (side walls, near top) ---
// Long axis runs along Z (depth), short axis along Y (height)
handle_slot_length_mm   = 120.0;        // Along Z (rack depth direction)
handle_slot_width_mm    = 42.0;         // Along Y (rack height direction)
handle_slot_radius_mm   = 5.0;          // Small rounded corners
handle_fillet_radius_mm = 2.0;          // Fillet on edges where handle meets wall exterior
handle_top_offset_mm    = 50.0;         // Distance from rack top to handle top edge
grip_bar_diameter_mm    = 21.6;         // Cylindrical grab bar at top of handle cutout

// --- Zip Tie Tower Parameters ---
zip_tower_base_mm       = 20.0;         // Base footprint (square)
zip_tower_top_mm        = 12.0;         // Flat top size (square)
zip_tower_height_mm     = 4.4;          // Tower height from wall surface
zip_tunnel_width_mm     = 8.0;          // Tunnel width
zip_tunnel_height_mm    = 2.4;          // Tunnel height
zip_cable_roof_mm       = 0.0;          // Tunnel starts at z=0 (bottom)

// --- Computed Dimensions ---
rack_height_mm      = rack_units * rack_unit_height_mm;                              // 266.7mm
outer_width_mm      = rack_panel_width_mm + 2 * wall_thickness_mm;                   // 264mm
outer_height_mm     = rack_height_mm + 2 * wall_thickness_mm + 2 * rail_margin_mm;   // 286.7mm
inner_height_mm     = outer_height_mm - 2 * wall_thickness_mm;                       // 276.7mm
inner_corner_radius_mm = max(0.1, edge_radius_mm - wall_thickness_mm);               // 3mm

// Mounting area Y bounds (holes only - rails extend full inner height)
mount_area_y_start_mm = wall_thickness_mm + rail_margin_mm;                          // 10mm
mount_area_y_end_mm   = mount_area_y_start_mm + rack_height_mm;                      // 276.7mm

// Mounting hole X positions (from outer left edge)
mount_hole_x_left_mm  = wall_thickness_mm +
    (rack_panel_width_mm - rack_rail_to_rail_center_mm) / 2;                         // ~13.74mm
mount_hole_x_right_mm = outer_width_mm - mount_hole_x_left_mm;                       // ~250.26mm

// Rail inner face X positions (facing rack interior)
rail_left_inner_x_mm  = wall_thickness_mm + rack_rail_width_mm;                      // 20.875mm
rail_right_inner_x_mm = outer_width_mm - wall_thickness_mm - rack_rail_width_mm;     // 243.125mm

// Handle position: 50mm from top of rack, centered along depth
handle_y_center_mm  = outer_height_mm - handle_top_offset_mm
                      - handle_slot_width_mm / 2;
handle_z_center_mm  = rack_depth_mm / 2;

// --- Print Fit Assertions (base rack) ---
assert(outer_width_mm <= printer_max_x_mm,
    str("Width ", outer_width_mm, "mm exceeds printer X=", printer_max_x_mm, "mm"));
assert(outer_height_mm <= printer_max_y_mm,
    str("Height ", outer_height_mm, "mm exceeds printer Y=", printer_max_y_mm, "mm"));
assert(rack_depth_mm <= printer_max_z_mm,
    str("Depth ", rack_depth_mm, "mm exceeds printer Z=", printer_max_z_mm, "mm"));

$fn = 48;

// =========================================
// SHARED MODULES
// =========================================

/**
 * Rounded Box
 *
 * Box with filleted edges along Z axis (vertical in print = no supports).
 * XY cross-section is a rounded rectangle.
 */
module rounded_box(w, h, d, r) {
    hull() {
        translate([r, r, 0])     cylinder(h = d, r = r);
        translate([w-r, r, 0])   cylinder(h = d, r = r);
        translate([r, h-r, 0])   cylinder(h = d, r = r);
        translate([w-r, h-r, 0]) cylinder(h = d, r = r);
    }
}

/**
 * Inner Cavity
 *
 * Interior void with rounded corners matching outer shell.
 * Extends through front and back (open both ends).
 */
module inner_cavity() {
    ir = inner_corner_radius_mm;
    translate([wall_thickness_mm, wall_thickness_mm, -1]) {
        hull() {
            translate([ir, ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([rack_panel_width_mm - ir, ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([ir, inner_height_mm - ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
            translate([rack_panel_width_mm - ir, inner_height_mm - ir, 0])
                cylinder(h = rack_depth_mm + 2, r = ir);
        }
    }
}

/**
 * Mounting Rail
 *
 * Strip at the front of the rack interior with 45-degree bevel on back inner edge.
 * Extends full inner height for structural rigidity.
 *
 * Parameters:
 *   x_start:    X position of rail left edge
 *   bevel_side: "right" = bevel on right edge (left rail), "left" = bevel on left edge (right rail)
 */
module mounting_rail(x_start, bevel_side = "right") {
    b = rail_bevel_mm;
    bevel_remainder = max(0.01, rack_rail_width_mm - b);
    union() {
        // Front portion: full width
        translate([x_start, wall_thickness_mm, 0])
            cube([rack_rail_width_mm, inner_height_mm, rail_depth_mm - b]);
        // Back portion with 45-degree bevel on inner edge
        if (bevel_side == "right") {
            hull() {
                translate([x_start, wall_thickness_mm, rail_depth_mm - b])
                    cube([rack_rail_width_mm, inner_height_mm, 0.01]);
                translate([x_start, wall_thickness_mm, rail_depth_mm - 0.01])
                    cube([bevel_remainder, inner_height_mm, 0.01]);
            }
        } else {
            hull() {
                translate([x_start, wall_thickness_mm, rail_depth_mm - b])
                    cube([rack_rail_width_mm, inner_height_mm, 0.01]);
                translate([x_start + rack_rail_width_mm - bevel_remainder, wall_thickness_mm, rail_depth_mm - 0.01])
                    cube([bevel_remainder, inner_height_mm, 0.01]);
            }
        }
    }
}

/**
 * Back Mounting Rail
 *
 * Mirror of front rail at the back of the rack.
 * 45-degree bevel on the front-facing inner edge.
 */
module back_mounting_rail(x_start, bevel_side = "right") {
    b = rail_bevel_mm;
    bz = back_rail_z_start_mm;
    bevel_remainder = max(0.01, rack_rail_width_mm - b);
    union() {
        // Back portion: full width
        translate([x_start, wall_thickness_mm, bz + b])
            cube([rack_rail_width_mm, inner_height_mm, rail_depth_mm - b]);
        // Front portion with 45-degree bevel on inner edge
        if (bevel_side == "right") {
            hull() {
                translate([x_start, wall_thickness_mm, bz + b])
                    cube([rack_rail_width_mm, inner_height_mm, 0.01]);
                translate([x_start, wall_thickness_mm, bz])
                    cube([bevel_remainder, inner_height_mm, 0.01]);
            }
        } else {
            hull() {
                translate([x_start, wall_thickness_mm, bz + b])
                    cube([rack_rail_width_mm, inner_height_mm, 0.01]);
                translate([x_start + rack_rail_width_mm - bevel_remainder, wall_thickness_mm, bz])
                    cube([bevel_remainder, inner_height_mm, 0.01]);
            }
        }
    }
}

/**
 * Mounting Holes
 *
 * Screw clearance holes for one side. 3 holes per U, EIA-310 pattern.
 * Positioned within the rail_margin-inset mounting area.
 */
module mounting_holes(x_pos) {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];
            translate([x_pos, y_pos, -1])
                cylinder(h = rail_depth_mm + 2, d = mount_hole_diameter_mm);
        }
    }
}

/**
 * Nut Traps - Left Side
 *
 * M6 hex nut pockets behind screw holes with internal access slots.
 * Slots open on the rail inner face (toward rack interior) only.
 *
 * Each trap has:
 *   1. Hex pocket for the nut (rotated 30 deg for flat-to-slot alignment)
 *   2. Rectangular slot from rail inner face to pocket (nut slides in from inside rack)
 *   3. V bevel above pocket (pointed ceiling for support-free printing)
 */
module nut_traps_left() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            // Hex nut pocket
            translate([mount_hole_x_left_mm, y_pos, nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

            // Internal slot from rail inner face to nut pocket
            translate([mount_hole_x_left_mm - nut_pocket_af_mm / 2,
                       y_pos - nut_slot_width_mm / 2,
                       nut_z_start_mm])
                cube([rail_left_inner_x_mm - mount_hole_x_left_mm + nut_pocket_af_mm / 2 + 1,
                      nut_slot_width_mm,
                      nut_pocket_depth_mm]);

            // V bevel above nut pocket, spanning full rail width
            hull() {
                translate([wall_thickness_mm,
                           y_pos - nut_hex_od_mm / 2,
                           nut_z_start_mm + nut_pocket_depth_mm])
                    cube([rack_rail_width_mm, nut_hex_od_mm, 0.01]);
                translate([wall_thickness_mm,
                           y_pos - 0.005,
                           nut_z_start_mm + nut_pocket_depth_mm + nut_bevel_height_mm])
                    cube([rack_rail_width_mm, 0.01, 0.01]);
            }
        }
    }
}

/**
 * Nut Traps - Right Side
 *
 * Mirror of left side. Slots open on right rail inner face (toward rack interior).
 */
module nut_traps_right() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            // Hex nut pocket
            translate([mount_hole_x_right_mm, y_pos, nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

            // Internal slot from rail inner face to nut pocket
            translate([rail_right_inner_x_mm - 1,
                       y_pos - nut_slot_width_mm / 2,
                       nut_z_start_mm])
                cube([mount_hole_x_right_mm + nut_pocket_af_mm / 2 - rail_right_inner_x_mm + 1,
                      nut_slot_width_mm,
                      nut_pocket_depth_mm]);

            // V bevel above nut pocket, spanning full rail width
            hull() {
                translate([rail_right_inner_x_mm,
                           y_pos - nut_hex_od_mm / 2,
                           nut_z_start_mm + nut_pocket_depth_mm])
                    cube([rack_rail_width_mm, nut_hex_od_mm, 0.01]);
                translate([rail_right_inner_x_mm,
                           y_pos - 0.005,
                           nut_z_start_mm + nut_pocket_depth_mm + nut_bevel_height_mm])
                    cube([rack_rail_width_mm, 0.01, 0.01]);
            }
        }
    }
}

/**
 * Back Mounting Holes
 *
 * Screw clearance holes through the back rails for one side.
 */
module back_mounting_holes(x_pos) {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];
            translate([x_pos, y_pos, back_rail_z_start_mm - 1])
                cylinder(h = rail_depth_mm + 2, d = mount_hole_diameter_mm);
        }
    }
}

/**
 * Back Nut Traps - Left Side
 *
 * M6 hex nut pockets in back left rail.
 * V bevel above pocket (toward back of rack) for support-free printing.
 */
module back_nut_traps_left() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            // Hex nut pocket
            translate([mount_hole_x_left_mm, y_pos, back_nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

            // Internal slot from rail inner face to nut pocket
            translate([mount_hole_x_left_mm - nut_pocket_af_mm / 2,
                       y_pos - nut_slot_width_mm / 2,
                       back_nut_z_start_mm])
                cube([rail_left_inner_x_mm - mount_hole_x_left_mm + nut_pocket_af_mm / 2 + 1,
                      nut_slot_width_mm,
                      nut_pocket_depth_mm]);

            // V bevel below nut pocket (toward front), spanning full rail width
            hull() {
                translate([wall_thickness_mm,
                           y_pos - nut_hex_od_mm / 2,
                           back_nut_z_start_mm])
                    cube([rack_rail_width_mm, nut_hex_od_mm, 0.01]);
                translate([wall_thickness_mm,
                           y_pos - 0.005,
                           back_nut_z_start_mm - nut_bevel_height_mm])
                    cube([rack_rail_width_mm, 0.01, 0.01]);
            }
        }
    }
}

/**
 * Back Nut Traps - Right Side
 *
 * M6 hex nut pockets in back right rail.
 * V bevel below pocket (toward front of rack).
 */
module back_nut_traps_right() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : rack_units - 1]) {
        for (i = [0 : 2]) {
            y_pos = mount_area_y_start_mm + u * rack_unit_height_mm + offsets[i];

            // Hex nut pocket
            translate([mount_hole_x_right_mm, y_pos, back_nut_z_start_mm])
                rotate([0, 0, 30])
                    cylinder(h = nut_pocket_depth_mm, d = nut_hex_od_mm, $fn = 6);

            // Internal slot from rail inner face to nut pocket
            translate([rail_right_inner_x_mm - 1,
                       y_pos - nut_slot_width_mm / 2,
                       back_nut_z_start_mm])
                cube([mount_hole_x_right_mm + nut_pocket_af_mm / 2 - rail_right_inner_x_mm + 1,
                      nut_slot_width_mm,
                      nut_pocket_depth_mm]);

            // V bevel below nut pocket (toward front), spanning full rail width
            hull() {
                translate([rail_right_inner_x_mm,
                           y_pos - nut_hex_od_mm / 2,
                           back_nut_z_start_mm])
                    cube([rack_rail_width_mm, nut_hex_od_mm, 0.01]);
                translate([rail_right_inner_x_mm,
                           y_pos - 0.005,
                           back_nut_z_start_mm - nut_bevel_height_mm])
                    cube([rack_rail_width_mm, 0.01, 0.01]);
            }
        }
    }
}

/**
 * Handle Cutout
 *
 * Filleted rectangular slot through side wall for carrying the rack.
 * Long axis along Z (depth), short axis along Y (height).
 * All edges where the handle meets the wall exterior are filleted
 * using minkowski with a sphere for a smooth, comfortable grip.
 *
 * Parameters:
 *   x_start: X position to begin cutout (just outside the wall)
 */
module handle_cutout(x_start) {
    r = handle_slot_radius_mm;

    translate([x_start - 1, handle_y_center_mm, handle_z_center_mm])
        rotate([0, 90, 0])
            linear_extrude(wall_thickness_mm + 4)
                offset(r = r) offset(delta = -r)
                    square([handle_slot_length_mm, handle_slot_width_mm], center = true);
}

/**
 * Grip Bar
 *
 * Cylindrical grab bar with rounded (hemispherical) ends inside a handle cutout.
 * Positioned at the top edge of the handle opening so upper half is embedded
 * in the wall above, lower half protrudes into the handle opening as a grip.
 *
 * Parameters:
 *   wall_x_center: X center of the wall containing this grip bar
 */
module grip_bar(wall_x_center) {
    r = grip_bar_diameter_mm / 2;
    bar_y = handle_y_center_mm + handle_slot_width_mm / 2
            + grip_bar_diameter_mm / 2 - 3;  // Bar 3mm down into handle opening
    z_start = handle_z_center_mm - handle_slot_length_mm / 2 - 8;
    z_end   = handle_z_center_mm + handle_slot_length_mm / 2 + 8;

    // Capsule: hull of two spheres (rounded ends)
    hull() {
        translate([wall_x_center, bar_y, z_start + r])
            sphere(r = r, $fn = 32);
        translate([wall_x_center, bar_y, z_end - r])
            sphere(r = r, $fn = 32);
    }
}

// =========================================
// ZIP TIE TOWERS
// =========================================

/**
 * Zip Tie Tower
 *
 * Truncated pyramid with cross-shaped tunnel at the base.
 * Centered at origin in XY, extends in +Z.
 *
 * Structure (from base up):
 *   0 to cable_roof:  solid base (cable roof)
 *   cable_roof to cable_roof+tunnel_height: cross-shaped tunnel (zip tie threads here)
 *   above tunnel: solid pyramid tapering to flat top
 */
module zip_tie_tower() {
    base = zip_tower_base_mm;
    top_w = zip_tower_top_mm;
    h = zip_tower_height_mm;
    tw = zip_tunnel_width_mm;
    th = zip_tunnel_height_mm;
    roof = zip_cable_roof_mm;

    render() difference() {
        // Truncated pyramid
        hull() {
            translate([-base/2, -base/2, 0])
                cube([base, base, 0.01]);
            translate([-top_w/2, -top_w/2, h - 0.01])
                cube([top_w, top_w, 0.01]);
        }
        // Cross-shaped V-tunnel (45-degree sides, wide at bottom, 4mm plateau at top)
        // X direction
        hull() {
            translate([-base/2 - 1, -tw/2, roof])
                cube([base + 2, tw, 0.01]);
            translate([-base/2 - 1, -4/2, roof + th])
                cube([base + 2, 4, 0.01]);
        }
        // Y direction
        hull() {
            translate([-tw/2, -base/2 - 1, roof])
                cube([tw, base + 2, 0.01]);
            translate([-4/2, -base/2 - 1, roof + th])
                cube([4, base + 2, 0.01]);
        }
    }
}

/**
 * Zip Tie Tower Grid - All Interior Walls
 *
 * Side walls (left/right): 3 columns (Z) x 4 rows (Y)
 *   Y rows: 20mm from bottom, midpoint, 20mm below handle, 10mm from top
 *   Z columns: evenly spaced between front and back rails
 *
 * Top/bottom walls: 5 columns (X) x 4 rows (Z)
 *   Z rows: 20mm from front, 2 evenly spaced, 20mm from back
 *   X columns: evenly spaced between rail inner faces
 */
module zip_tie_towers() {
    // --- Side wall Y positions (4 rows) ---
    side_y1 = wall_thickness_mm + 20;                                    // 20mm from bottom
    side_y3 = handle_y_center_mm - handle_slot_width_mm / 2 - 20;       // 20mm below handle
    side_y2 = (side_y1 + side_y3) / 2;                                  // midpoint
    side_y4 = outer_height_mm - wall_thickness_mm - 10;                  // 10mm from top
    side_y_positions = [side_y1, side_y2, side_y3, side_y4];

    // --- Side wall Z positions (3 columns, evenly spaced between rails) ---
    sz_min = rail_depth_mm;
    sz_max = rack_depth_mm - rail_depth_mm;
    side_z_positions = [for (i = [1:3]) sz_min + (sz_max - sz_min) / 4 * i];

    // --- Top/bottom Z positions (4 rows) ---
    tb_z1 = 20;
    tb_z4 = rack_depth_mm - 20;
    tb_z_positions = [for (i = [0:3]) tb_z1 + (tb_z4 - tb_z1) / 3 * i];

    // --- Top/bottom X positions (5 columns between rail inner faces) ---
    tx_min = rail_left_inner_x_mm;
    tx_max = rail_right_inner_x_mm;
    tb_x_positions = [for (i = [1:5]) tx_min + (tx_max - tx_min) / 6 * i];

    // Left wall (towers project in +X)
    for (iy = [0 : len(side_y_positions) - 1]) {
        for (iz = [0 : len(side_z_positions) - 1]) {
            translate([wall_thickness_mm, side_y_positions[iy], side_z_positions[iz]])
                rotate([0, 90, 0])
                    zip_tie_tower();
        }
    }

    // Right wall (towers project in -X)
    for (iy = [0 : len(side_y_positions) - 1]) {
        for (iz = [0 : len(side_z_positions) - 1]) {
            translate([outer_width_mm - wall_thickness_mm, side_y_positions[iy], side_z_positions[iz]])
                rotate([0, -90, 0])
                    zip_tie_tower();
        }
    }

    // Bottom wall (towers project in +Y)
    for (ix = [0 : len(tb_x_positions) - 1]) {
        for (iz = [0 : len(tb_z_positions) - 1]) {
            translate([tb_x_positions[ix], wall_thickness_mm, tb_z_positions[iz]])
                rotate([-90, 0, 0])
                    zip_tie_tower();
        }
    }

    // Top wall (towers project in -Y)
    for (ix = [0 : len(tb_x_positions) - 1]) {
        for (iz = [0 : len(tb_z_positions) - 1]) {
            translate([tb_x_positions[ix], outer_height_mm - wall_thickness_mm, tb_z_positions[iz]])
                rotate([90, 0, 0])
                    zip_tie_tower();
        }
    }
}

// =========================================
// DEBUG
// =========================================

module debug_axes(length = 50) {
    color("red")   cylinder(h = length, r = 1, $fn = 16);
    color("green") rotate([0, 90, 0]) cylinder(h = length, r = 1, $fn = 16);
    color("blue")  rotate([-90, 0, 0]) cylinder(h = length, r = 1, $fn = 16);
}
