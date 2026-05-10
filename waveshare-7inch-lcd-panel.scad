/**
 * 10-Inch Rack-Mount Display Panel for Waveshare 7inch HDMI LCD (B)
 * 3U faceplate holding the LCD with 4 M3 screws and fastened to the rack
 * rails with 18 M6 screws (9 rows per rail, full EIA-310 3U hole pattern).
 *
 * Prints face-down on Bambu Labs H2D - front face at Z=0, no supports.
 *
 * Bambu Labs H2D Build Volume (single nozzle): 325 x 320 x 325 mm
 * This model footprint: 254 x 133.35 mm
 *
 * Hardware reference: waveshare-7inch-lcd-display-b.md
 * Vendor drawing:     https://files.waveshare.com/wiki/7inch%20HDMI%20LCD%20(B)/7inch%20HDMI%20LCD%20(B).pdf
 *
 * COMPONENT INDEX
 *   panel_slab              [0,0,0] to [254, 133.35, 5]           faceplate
 *   lcd_window_cutout       window in front face                  LCD viewport
 *   lcd_mounting_bosses     4 cylinders at PCB hole positions     support LCD at correct depth
 *   lcd_screw_holes         4 through-holes Ø3.25                 M3 screws for LCD
 *   rack_mounting_holes     18 holes (9 per rail)                 M6 rack screws (EIA-310 3U)
 */

include <all-racks-config.scad>

// =========================================
// LCD PARAMETERS (from waveshare-7inch-lcd-display-b.md)
// =========================================

lcd_pcb_width_mm        = 164.90;   // PCB outline
lcd_pcb_height_mm       = 124.27;
lcd_module_thickness_mm = 8.30;     // Total LCD module depth (glass + PCB + components)
lcd_pcb_thickness_mm    = 1.60;
lcd_hole_spacing_x_mm   = 156.90;   // Mounting hole center-to-center (horizontal)
lcd_hole_spacing_y_mm   = 114.96;   // Mounting hole center-to-center (vertical)
lcd_hole_diameter_mm    = 3.25;     // 4 x Ø3.25 (M3 clearance)

// =========================================
// PANEL PARAMETERS
// =========================================

panel_units_u           = 3;                                          // 3U faceplate
panel_width_mm          = rack_panel_width_mm;                        // 254 (10" rack)
panel_height_mm         = panel_units_u * rack_unit_height_mm;        // 133.35
panel_thickness_mm      = wall_thickness_mm;                          // 5.0

// LCD bezel window (rectangular cutout in front face)
// NOTE: Conservative size below the VA (154.58 x 86.42 mm) to keep the M3
// screw holes clear of the window edge. Refine to taste after mockup.
lcd_window_width_mm     = 156.00;
lcd_window_height_mm    = 89.00;

// Window offset from centered position (positive = right/up, negative = left/down)
lcd_window_offset_x_mm  =  1.00;
lcd_window_offset_y_mm  =  4.00;

// LCD window bevel: the cutout tapers from (lcd_window_* + 2*bevel) at the
// FRONT face (Z=0) inward to lcd_window_* at the BACK face. Visually this
// flares the front opening outward toward the viewer for a wider sightline
// onto the LCD. Printability (face-down): the cutout NARROWS with Z, so the
// panel material extends inward over the layer below -- a mild overhang of
// atan(bevel / panel_thickness). At 3 mm / 5 mm = ~31 deg from vertical,
// inside the 45 deg unsupported limit on the Bambu H2D.
lcd_window_bevel_mm     = 3.00;

// LCD mounting boss (cylindrical standoff on the back of the panel)
// Length = LCD module thickness minus PCB thickness, so the PCB back lands
// on the boss tip when the glass front rests against the panel back.
lcd_boss_diameter_mm    = 7.00;
lcd_boss_length_mm      = lcd_module_thickness_mm - lcd_pcb_thickness_mm;  // 6.70

// LCD screw head inset (counterbore pocket on the front face of the panel)
// Sits concentric with each M3 through-hole so the screw head recesses below
// the front face of the panel.
lcd_screw_inset_diameter_mm = 5.00;
lcd_screw_inset_depth_mm    = 2.00;

// Centering pins (test fit). When enabled, solid 2.5 mm dia x 5 mm posts
// protrude from the tip of each LCD mounting boss, sized to slip into the
// LCD's Ø3.25 mounting holes for a no-screw alignment dry-fit. When enabled
// the M3 through-holes are NOT subtracted (the post must be solid through
// the boss). Set false for the production part.
enable_centering_pins         = true;
lcd_centering_pin_diameter_mm = 2.50;
lcd_centering_pin_length_mm   = 5.00;

// Uniform 1 mm corner rounding on every transition.
// Applied via minkowski() with a sphere so ALL edges (Z-parallel AND the front
// and back face perimeters) get filleted. No 90-degree corners remain on the
// plate body or the LCD window cutout.
//
// Printability note: the front face (Z=0) edges grow outward from Z=0 to Z=r,
// an average 45-deg expansion. The Bambu H2D handles this without supports.
// The back face (Z=T) edges retreat inward as Z increases -- fully supported.
corner_radius_mm = 1.00;
corner_sphere_fn = 12;   // Facet count for the minkowski sphere (lower = faster preview)

// Rack mounting hole X positions (reuses the rack's rail center spacing)
panel_rack_hole_x_left_mm  = (panel_width_mm - rack_rail_to_rail_center_mm) / 2;     // 8.7375
panel_rack_hole_x_right_mm = panel_width_mm - panel_rack_hole_x_left_mm;             // 245.2625

// =========================================
// COMPUTED POSITIONS
// =========================================

// PCB is centered on the panel; mounting holes are inset from the PCB edges.
lcd_pcb_x0_mm = (panel_width_mm  - lcd_pcb_width_mm)  / 2;   // 44.55
lcd_pcb_y0_mm = (panel_height_mm - lcd_pcb_height_mm) / 2;   // 4.54
lcd_hole_inset_x_mm = (lcd_pcb_width_mm  - lcd_hole_spacing_x_mm) / 2;   // 4.00
lcd_hole_inset_y_mm = (lcd_pcb_height_mm - lcd_hole_spacing_y_mm) / 2;   // 4.655

// Absolute panel coordinates of the 4 LCD mounting hole centers
lcd_hole_positions = [
    [lcd_pcb_x0_mm + lcd_hole_inset_x_mm,                        // BL
     lcd_pcb_y0_mm + lcd_hole_inset_y_mm],
    [lcd_pcb_x0_mm + lcd_pcb_width_mm  - lcd_hole_inset_x_mm,    // BR
     lcd_pcb_y0_mm + lcd_hole_inset_y_mm],
    [lcd_pcb_x0_mm + lcd_hole_inset_x_mm,                        // TL
     lcd_pcb_y0_mm + lcd_pcb_height_mm - lcd_hole_inset_y_mm],
    [lcd_pcb_x0_mm + lcd_pcb_width_mm  - lcd_hole_inset_x_mm,    // TR
     lcd_pcb_y0_mm + lcd_pcb_height_mm - lcd_hole_inset_y_mm]
];

// LCD window cutout (centered on panel, plus offset)
lcd_window_x0_mm = (panel_width_mm  - lcd_window_width_mm)  / 2 + lcd_window_offset_x_mm;
lcd_window_y0_mm = (panel_height_mm - lcd_window_height_mm) / 2 + lcd_window_offset_y_mm;

// --- Print fit assertions ---
assert(panel_width_mm <= printer_max_x_mm,
    str("Panel width ", panel_width_mm, " exceeds printer X=", printer_max_x_mm));
assert(panel_height_mm <= printer_max_y_mm,
    str("Panel height ", panel_height_mm, " exceeds printer Y=", printer_max_y_mm));

// =========================================
// MODULES
// =========================================

/**
 * Panel Slab
 *
 * Flat rectangular front panel, minkowski-rounded by a 1 mm sphere so every
 * outer edge (Z-parallel corners AND front/back face perimeters) is filleted.
 * The minkowski result spans [0, 0, 0] to [panel_w, panel_h, panel_t]; the
 * source cube is inset by r on all sides so the resulting bounding box matches
 * the nominal panel dimensions exactly.
 * BOUNDING BOX: [0, 0, 0] to [254, 133.35, 5]
 */
module panel_slab() {
    r = corner_radius_mm;
    minkowski() {
        translate([r, r, r])
            cube([panel_width_mm  - 2 * r,
                  panel_height_mm - 2 * r,
                  panel_thickness_mm - 2 * r]);
        sphere(r = r, $fn = corner_sphere_fn);
    }
}

/**
 * LCD Window Cutout (beveled, flared toward front)
 *
 * Tapered through-hole. Cross-section at the FRONT face (Z=0) is expanded by
 * lcd_window_bevel_mm on every side; cross-section at the BACK face
 * (Z=panel_thickness) is the nominal lcd_window_*_mm rectangle (matching the
 * LCD glass it sits against). The bevel is a linear taper between the two,
 * formed by hull()-ing a thin slice at each face.
 *
 * Both faces' Z-parallel corners are filleted to corner_radius_mm via
 * minkowski() with a short cylinder. Front and back extension blocks (1 mm
 * past each face) ensure clean boolean subtraction with no coincident-face
 * slivers.
 *
 * Printability (face-down): the cutout NARROWS with Z. Panel material
 * extends inward over the layer below -- a mild overhang of
 * atan(bevel / panel_thickness). At 3 mm / 5 mm = ~31 deg from vertical,
 * within the 45 deg unsupported limit on the Bambu H2D.
 */
module lcd_window_cutout() {
    r = corner_radius_mm;
    b = lcd_window_bevel_mm;

    // Beveled taper: hull of a thin large slice at the front face and a thin
    // small slice at the back face -> linear cross-section interpolation in Z.
    hull() {
        translate([lcd_window_x0_mm - b + r, lcd_window_y0_mm - b + r, 0])
            minkowski() {
                cube([lcd_window_width_mm  + 2 * b - 2 * r,
                      lcd_window_height_mm + 2 * b - 2 * r,
                      0.001]);
                cylinder(r = r, h = 0.001, $fn = corner_sphere_fn);
            }
        translate([lcd_window_x0_mm + r, lcd_window_y0_mm + r, panel_thickness_mm - 0.001])
            minkowski() {
                cube([lcd_window_width_mm  - 2 * r,
                      lcd_window_height_mm - 2 * r,
                      0.001]);
                cylinder(r = r, h = 0.001, $fn = corner_sphere_fn);
            }
    }

    // Front extension below Z=0 (large cross-section, matches front face)
    translate([lcd_window_x0_mm - b + r, lcd_window_y0_mm - b + r, -1])
        minkowski() {
            cube([lcd_window_width_mm  + 2 * b - 2 * r,
                  lcd_window_height_mm + 2 * b - 2 * r,
                  1.001]);
            cylinder(r = r, h = 0.001, $fn = corner_sphere_fn);
        }

    // Back extension above Z=panel_thickness (small cross-section, matches back face)
    translate([lcd_window_x0_mm + r, lcd_window_y0_mm + r, panel_thickness_mm])
        minkowski() {
            cube([lcd_window_width_mm  - 2 * r,
                  lcd_window_height_mm - 2 * r,
                  1.001]);
            cylinder(r = r, h = 0.001, $fn = corner_sphere_fn);
        }
}

/**
 * LCD Screw Head Insets
 *
 * Four shallow cylindrical pockets on the front face of the panel, concentric
 * with the M3 through-holes. Each pocket is lcd_screw_inset_diameter_mm wide
 * and lcd_screw_inset_depth_mm deep, so the screw head sits recessed below
 * the front face. The 2 mm floor of each pocket bridges a small annular span
 * around the Ø3.25 through-hole, which is well within printable bridge limits.
 */
module lcd_screw_head_insets() {
    for (p = lcd_hole_positions) {
        translate([p[0], p[1], -0.01])
            cylinder(
                h = lcd_screw_inset_depth_mm + 0.01,
                d = lcd_screw_inset_diameter_mm);
    }
}

/**
 * LCD Mounting Bosses (nubs)
 *
 * Four standoffs on the back of the panel at the LCD PCB mounting hole
 * positions. Each boss has a chamfered base (a truncated cone r tall that
 * tapers from lcd_boss_diameter+2r down to lcd_boss_diameter) so the junction
 * with the panel back has no 90-degree corner, followed by a straight
 * cylindrical body. Total length = lcd_boss_length_mm, so the PCB back sits
 * flush with the boss tip when the glass rests against the panel back.
 *
 * Each boss is paired with a through-hole in lcd_screw_holes() for the M3
 * screw that secures the LCD.
 */
module lcd_mounting_bosses() {
    r = corner_radius_mm;
    for (p = lcd_hole_positions) {
        // Chamfered base: r tall, tapering from D+2r to D
        hull() {
            translate([p[0], p[1], panel_thickness_mm])
                cylinder(h = 0.01, d = lcd_boss_diameter_mm + 2 * r);
            translate([p[0], p[1], panel_thickness_mm + r])
                cylinder(h = 0.01, d = lcd_boss_diameter_mm);
        }
        // Straight cylindrical body above the chamfer
        translate([p[0], p[1], panel_thickness_mm + r])
            cylinder(h = lcd_boss_length_mm - r, d = lcd_boss_diameter_mm);
    }
}

/**
 * LCD Screw Holes
 *
 * Four Ø3.25 mm clearance holes running from the front face of the panel
 * through each boss. Lets an M3 machine screw pass through the panel and
 * thread into the LCD PCB (with nut or heat-set insert at the back).
 */
module lcd_screw_holes() {
    for (p = lcd_hole_positions) {
        translate([p[0], p[1], -1])
            cylinder(
                h = panel_thickness_mm + lcd_boss_length_mm + 2,
                d = lcd_hole_diameter_mm);
    }
}

/**
 * LCD Centering Pins (test fit)
 *
 * Solid posts at each LCD mounting hole position, protruding from the boss
 * tip outward (back of panel) by lcd_centering_pin_length_mm. Diameter is
 * sized to slip into the LCD's Ø3.25 mounting holes for a no-screw dry fit
 * to verify hole alignment with the LCD PCB.
 *
 * NOTE: When enable_centering_pins is true, lcd_screw_holes() is skipped in
 * the assembly so the post remains solid through the boss.
 */
module lcd_centering_pins() {
    boss_tip_z = panel_thickness_mm + lcd_boss_length_mm;
    for (p = lcd_hole_positions) {
        translate([p[0], p[1], boss_tip_z])
            cylinder(
                h = lcd_centering_pin_length_mm,
                d = lcd_centering_pin_diameter_mm);
    }
}

/**
 * Rack Mounting Holes
 *
 * 9 rows per rail (3 holes per U x 3U = 9) on each side.
 * M6 clearance (6.5 mm) to match the main rack mount_hole_diameter_mm.
 *
 * Row layout within each U (from bottom):
 *   0.25"  =  6.35 mm
 *   0.875" = 22.225 mm
 *   1.50"  = 38.10 mm
 */
module rack_mounting_holes() {
    offsets = [rack_hole_offset_1_mm, rack_hole_offset_2_mm, rack_hole_offset_3_mm];
    for (u = [0 : panel_units_u - 1]) {
        for (i = [0 : 2]) {
            y = u * rack_unit_height_mm + offsets[i];
            for (x = [panel_rack_hole_x_left_mm, panel_rack_hole_x_right_mm]) {
                translate([x, y, -1])
                    cylinder(h = panel_thickness_mm + 2, d = mount_hole_diameter_mm);
            }
        }
    }
}

/**
 * Display Mount Panel
 *
 * Full assembly:
 *   panel_slab + lcd_mounting_bosses
 *     - lcd_window_cutout
 *     - lcd_screw_holes
 *     - lcd_screw_head_insets
 *     - rack_mounting_holes
 */
module display_mount_panel() {
    difference() {
        union() {
            panel_slab();
            lcd_mounting_bosses();
            if (enable_centering_pins) lcd_centering_pins();
        }
        lcd_window_cutout();
        if (!enable_centering_pins) lcd_screw_holes();
        lcd_screw_head_insets();
        rack_mounting_holes();
    }
}

// =========================================
// DEBUG / VISUALIZATION
// =========================================

module assembly_colored() {
    color("DimGray", 0.9) display_mount_panel();
}

module assembly_xray() {
    color("SteelBlue", 0.4) display_mount_panel();
}

// =========================================
// DEFAULT RENDER
// =========================================

assembly_colored();
