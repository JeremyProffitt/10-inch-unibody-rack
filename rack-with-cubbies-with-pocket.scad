/**
 * 10-Inch Unibody Server Rack (6U) with Side Cubbies and USW Flex Mini Pocket
 * Prints in one piece on Bambu Labs H2D - front face down, no supports
 *
 * Extends the right side of the rack by 55mm with horizontal shelves
 * every 4 inches, creating storage cubbies alongside the rack.
 * Includes a pocket on the right interior wall (divider) for a Ubiquiti
 * USW Flex Mini switch, with 45-degree ramp underneath.
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 * This model footprint: 319 x 286.7 mm (fits within 325 x 320 bed)
 */

include <all-racks-config.scad>

// =========================================
// CUBBY EXTENSION PARAMETERS
// =========================================

cubby_width_mm          = 44.0;         // Total extension width
shelf_spacing_mm        = 101.6;        // 4 inches between shelves

// --- Cubby Computed Dimensions ---
total_outer_width_mm = outer_width_mm + cubby_width_mm;                              // 308mm
cubby_inner_width_mm = cubby_width_mm - wall_thickness_mm;                           // 39mm
num_shelves = floor(inner_height_mm / shelf_spacing_mm);                             // 2

// --- Print Fit Assertions (extended width including grip bar protrusion) ---
grip_bar_protrusion_mm = grip_bar_diameter_mm / 2 - wall_thickness_mm / 2;           // 8.3mm
total_envelope_x_mm = total_outer_width_mm + 2 * grip_bar_protrusion_mm;
assert(total_envelope_x_mm <= printer_max_x_mm,
    str("X envelope ", total_envelope_x_mm, "mm exceeds printer X=", printer_max_x_mm, "mm"));

// =========================================
// USW FLEX MINI POCKET (right/divider wall, bottom)
// =========================================

// Switch dimensions
usw_length_mm  = 107.16;       // Long side
usw_width_mm   = 70.15;        // Short side (pocket depth)
usw_height_mm  = 21.17;        // Thickness (into rack interior)

pocket_clearance_mm = 0.5;
pocket_wall_mm      = 3.0;

// Cavity dimensions (switch + clearance)
pocket_cav_x_mm = usw_height_mm + 2 * pocket_clearance_mm;     // 22.17
pocket_cav_y_mm = usw_length_mm + 2 * pocket_clearance_mm;     // 108.16
pocket_cav_z_mm = usw_width_mm  + pocket_clearance_mm;         // 70.65 (open top)

// Exterior dimensions (cavity + walls)
pocket_ext_x_mm = pocket_cav_x_mm + pocket_wall_mm;            // 25.17 (one wall on interior side)
pocket_ext_y_mm = pocket_cav_y_mm + 2 * pocket_wall_mm;        // 114.16
pocket_ext_z_mm = pocket_cav_z_mm + pocket_wall_mm;            // 73.65 (one wall on bottom, open top)

// Position: against divider wall (original right wall) inner surface, flush with bottom, centered Z
pocket_x_mm = outer_width_mm - wall_thickness_mm - pocket_ext_x_mm;
pocket_y_mm = wall_thickness_mm;
pocket_z_mm = rack_depth_mm / 2 - pocket_ext_z_mm / 2;

module usw_pocket_solid() {
    translate([pocket_x_mm, pocket_y_mm, pocket_z_mm])
        cube([pocket_ext_x_mm, pocket_ext_y_mm, pocket_ext_z_mm]);
}

module usw_pocket_cavity() {
    // Main cavity (open top)
    translate([pocket_x_mm + pocket_wall_mm,
               pocket_y_mm + pocket_wall_mm,
               pocket_z_mm + pocket_wall_mm])
        cube([pocket_cav_x_mm,
              pocket_cav_y_mm,
              pocket_cav_z_mm + 1]);    // +1 extends through open top

    // Bottom opening (-Z side): 5mm inset on each Y side, 1mm inset on X front/back
    // Extends through pocket bottom wall AND the ramp below
    translate([pocket_x_mm + pocket_wall_mm + 1,
               pocket_y_mm + pocket_wall_mm + 5,
               pocket_z_mm - pocket_ext_x_mm - 1])
        cube([pocket_cav_x_mm - 2,
              pocket_cav_y_mm - 10,
              pocket_ext_x_mm + pocket_wall_mm + 2]);

    // Triangle cutout through pocket interior wall only (facing rack interior)
    // Base at bottom of ramp, apex 30mm above cavity floor
    // Limited to the 3mm pocket wall so the divider wall stays solid
    hull() {
        // Base: pocket interior wall width at bottom of pocket wall
        translate([pocket_x_mm - 1,
                   pocket_y_mm + pocket_wall_mm + 5,
                   pocket_z_mm - pocket_ext_x_mm - 1 + 20])
            cube([pocket_wall_mm + 2, pocket_cav_y_mm - 10, 0.01]);
        // Apex: center point 50mm above cavity floor
        translate([pocket_x_mm - 1,
                   pocket_y_mm + pocket_ext_y_mm / 2 - 0.005,
                   pocket_z_mm + pocket_wall_mm + 50])
            cube([pocket_wall_mm + 2, 0.01, 0.01]);
    }
}

// 45-degree ramp under pocket for support-free printing
// Slopes from full pocket width at z=pocket_z to wall surface at z=pocket_z - pocket_ext_x
module usw_pocket_ramp() {
    hull() {
        // Full bottom face of pocket
        translate([pocket_x_mm, pocket_y_mm, pocket_z_mm])
            cube([pocket_ext_x_mm, pocket_ext_y_mm, 0.01]);
        // Line at wall surface, one pocket_ext_x below
        translate([outer_width_mm - wall_thickness_mm - 0.01,
                   pocket_y_mm,
                   pocket_z_mm - pocket_ext_x_mm])
            cube([0.01, pocket_ext_y_mm, 0.01]);
    }
}

// =========================================
// CUBBY-SPECIFIC MODULES
// =========================================

/**
 * Cubby Inner Cavity
 *
 * Interior void for the cubby section (right side extension).
 * Separated from rack by the divider wall (original right wall).
 * Open at back, closed at front (5mm front wall).
 */
module cubby_inner_cavity() {
    ir = inner_corner_radius_mm;
    cubby_depth = rack_depth_mm - wall_thickness_mm + 1;
    translate([outer_width_mm, wall_thickness_mm, wall_thickness_mm]) {
        hull() {
            translate([ir, ir, 0])
                cylinder(h = cubby_depth, r = ir);
            translate([cubby_inner_width_mm - ir, ir, 0])
                cylinder(h = cubby_depth, r = ir);
            translate([ir, inner_height_mm - ir, 0])
                cylinder(h = cubby_depth, r = ir);
            translate([cubby_inner_width_mm - ir, inner_height_mm - ir, 0])
                cylinder(h = cubby_depth, r = ir);
        }
    }
}

/**
 * Cubby Shelves
 *
 * Horizontal shelves every 4 inches within the cubby section.
 * In print orientation these are vertical thin walls - no bridging.
 */
module cubby_shelves() {
    cubby_depth = rack_depth_mm - wall_thickness_mm;
    for (i = [1 : num_shelves]) {
        shelf_y = wall_thickness_mm + i * shelf_spacing_mm;
        if (shelf_y + wall_thickness_mm < outer_height_mm - wall_thickness_mm) {
            translate([outer_width_mm, shelf_y, wall_thickness_mm])
                cube([cubby_inner_width_mm, wall_thickness_mm, cubby_depth]);
        }
    }
}

// =========================================
// CUSTOM ZIP TIE TOWER LAYOUT
// =========================================

/**
 * Modified tower placement for rack with pocket:
 *   - Left wall: all 4 rows x 3 cols (unchanged)
 *   - Right wall (divider): top 2 rows only - bottom rows replaced by pocket
 *   - Top wall: unchanged (5 cols x 4 rows)
 *   - Bottom wall: rightmost 3 cols removed, remaining 2 shifted 50mm left
 */
module rack_towers() {
    // Side wall Y positions
    sy1 = wall_thickness_mm + 20;
    sy3 = handle_y_center_mm - handle_slot_width_mm / 2 - 20;
    sy2 = (sy1 + sy3) / 2;
    sy4 = outer_height_mm - wall_thickness_mm - 10;
    side_y = [sy1, sy2, sy3, sy4];

    // Side wall Z positions (3 cols between rails)
    sz_min = rail_depth_mm;
    sz_max = rack_depth_mm - rail_depth_mm;
    side_z = [for (i = [1:3]) sz_min + (sz_max - sz_min) / 4 * i];

    // Top/bottom Z positions (4 rows)
    tb_z1 = 20;
    tb_z4 = rack_depth_mm - 20;
    tb_z = [for (i = [0:3]) tb_z1 + (tb_z4 - tb_z1) / 3 * i];

    // Top/bottom X positions (5 cols between rail inner faces)
    tx_min = rail_left_inner_x_mm;
    tx_max = rail_right_inner_x_mm;
    tb_x = [for (i = [1:5]) tx_min + (tx_max - tx_min) / 6 * i];

    // --- Left wall: all 4 rows x 3 cols ---
    for (iy = [0:3]) {
        for (iz = [0:2]) {
            translate([wall_thickness_mm, side_y[iy], side_z[iz]])
                rotate([0, 90, 0]) zip_tie_tower();
        }
    }

    // --- Right wall (divider): top 2 rows only (skip bottom 2 for pocket) ---
    for (iy = [2:3]) {
        for (iz = [0:2]) {
            translate([outer_width_mm - wall_thickness_mm, side_y[iy], side_z[iz]])
                rotate([0, -90, 0]) zip_tie_tower();
        }
    }

    // --- Right wall: towers near pocket ---
    pocket_tower_spacing = 25;
    pocket_tower_z_back  = pocket_z_mm + pocket_ext_z_mm + pocket_tower_spacing;
    pocket_tower_y = [for (i = [1:3])
        pocket_y_mm + pocket_ext_y_mm / 4 * i];

    // 3 towers behind pocket opening
    for (iy = [0:2]) {
        translate([outer_width_mm - wall_thickness_mm, pocket_tower_y[iy], pocket_tower_z_back])
            rotate([0, -90, 0]) zip_tie_tower();
    }

    // --- Top wall: unchanged ---
    for (ix = [0:4]) {
        for (iz = [0:3]) {
            translate([tb_x[ix], outer_height_mm - wall_thickness_mm, tb_z[iz]])
                rotate([90, 0, 0]) zip_tie_tower();
        }
    }

    // --- Bottom wall: leftmost 2 cols shifted 50mm left, rightmost 3 removed ---
    for (ix = [0:1]) {
        for (iz = [0:3]) {
            translate([tb_x[ix] - 50, wall_thickness_mm, tb_z[iz]])
                rotate([-90, 0, 0]) zip_tie_tower();
        }
    }
}

// =========================================
// ASSEMBLY
// =========================================

/**
 * Complete Rack with Cubbies and USW Pocket Assembly
 *
 * Unibody 10-inch server rack with cubby extension on right side
 * and USW Flex Mini pocket on the divider wall.
 * Grip bars in both handle cutouts.
 *
 * BOUNDING BOX: [0, 0, 0] to [308, 286.7, 200]
 */
module rack_with_cubbies_and_pocket() {
    union() {
        difference() {
            union() {
                // Outer shell minus both cavities (leaves divider wall)
                difference() {
                    rounded_box(total_outer_width_mm, outer_height_mm, rack_depth_mm, edge_radius_mm);
                    inner_cavity();
                    cubby_inner_cavity();
                }

                // Front mounting rails (45-deg bevel on inner back edge)
                mounting_rail(wall_thickness_mm, "right");
                mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm, "left");

                // Back mounting rails (45-deg bevel on inner front edge)
                back_mounting_rail(wall_thickness_mm, "right");
                back_mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm, "left");

                // Cubby shelves
                cubby_shelves();

                // Custom zip tie tower layout (modified for pocket)
                rack_towers();

                // USW Flex Mini pocket + ramp
                usw_pocket_solid();
                usw_pocket_ramp();
            }

            // Front mounting screw holes
            mounting_holes(mount_hole_x_left_mm);
            mounting_holes(mount_hole_x_right_mm);

            // Back mounting screw holes
            back_mounting_holes(mount_hole_x_left_mm);
            back_mounting_holes(mount_hole_x_right_mm);

            // Front M6 nut traps (V bevel above)
            if (enable_nut_traps) {
                nut_traps_left();
                nut_traps_right();
            }

            // Back M6 nut traps (V bevel below)
            if (enable_nut_traps) {
                back_nut_traps_left();
                back_nut_traps_right();
            }

            // Filleted handle cutouts - left outer wall and right outer wall
            handle_cutout(-1);
            handle_cutout(total_outer_width_mm - wall_thickness_mm);

            // USW Flex Mini pocket cavity (also clears any overlapping towers)
            usw_pocket_cavity();
        }

        // Grip bars inside handle cutouts
        grip_bar(wall_thickness_mm / 2);                                    // Left wall
        grip_bar(total_outer_width_mm - wall_thickness_mm / 2);             // Right wall
    }
}

// =========================================
// DEBUG / VISUALIZATION
// =========================================

module assembly_colored() {
    color("DimGray", 0.9) rack_with_cubbies_and_pocket();
}

module assembly_xray() {
    color("SteelBlue", 0.4) rack_with_cubbies_and_pocket();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
