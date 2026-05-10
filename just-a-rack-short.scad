/**
 * 10-Inch Unibody Server Rack (6U) - "Just a Rack"
 * Prints in one piece on Bambu Labs H2D - front face down, no supports
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 * This model footprint: 264 x 310 mm (fits within 325 x 320 bed)
 */

include <all-racks-config.scad>

// =========================================
// ASSEMBLY
// =========================================

/**
 * Complete Rack Assembly
 *
 * BOUNDING BOX: [0, 0, 0] to [264, 286.7, 200]
 */
module rack() {
    union() {
        difference() {
            union() {
                // Outer shell minus inner cavity
                difference() {
                    rounded_box(outer_width_mm, outer_height_mm, rack_depth_mm, edge_radius_mm);
                    inner_cavity();
                }

                // Front mounting rails (45-deg bevel on inner back edge)
                mounting_rail(wall_thickness_mm, "right");
                mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm, "left");

                // Back mounting rails (45-deg bevel on inner front edge)
                back_mounting_rail(wall_thickness_mm, "right");
                back_mounting_rail(outer_width_mm - wall_thickness_mm - rack_rail_width_mm, "left");

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

            // Handle cutouts
            handle_cutout(-1);
            handle_cutout(outer_width_mm - wall_thickness_mm);
        }

        // Grip bars inside handle cutouts (added back after cutout subtraction)
        grip_bar(wall_thickness_mm / 2);                            // Left wall
        grip_bar(outer_width_mm - wall_thickness_mm / 2);           // Right wall
    }
}

// =========================================
// DEBUG / VISUALIZATION
// =========================================

module assembly_colored() {
    color("DimGray", 0.9) rack();
}

module assembly_xray() {
    color("SteelBlue", 0.4) rack();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
