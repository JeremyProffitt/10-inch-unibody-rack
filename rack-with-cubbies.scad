/**
 * 10-Inch Unibody Server Rack (6U) with Side Cubbies
 * Prints in one piece on Bambu Labs H2D - front face down, no supports
 *
 * Extends the right side of the rack by 55mm with horizontal shelves
 * every 4 inches, creating storage cubbies alongside the rack.
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
// ASSEMBLY
// =========================================

/**
 * Complete Rack with Cubbies Assembly
 *
 * Unibody 10-inch server rack with cubby extension on right side.
 * Original right wall becomes divider. Shelves every 4" in cubby.
 * Grip bars in both handle cutouts.
 *
 * BOUNDING BOX: [0, 0, 0] to [308, 286.7, 200]
 */
module rack_with_cubbies() {
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

                // Zip tie towers on all interior walls
                zip_tie_towers();
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
    color("DimGray", 0.9) rack_with_cubbies();
}

module assembly_xray() {
    color("SteelBlue", 0.4) rack_with_cubbies();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
