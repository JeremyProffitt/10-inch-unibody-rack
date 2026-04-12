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
lcd_window_width_mm     = 150.00;
lcd_window_height_mm    = 85.00;

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

// LCD window cutout (centered on panel)
lcd_window_x0_mm = (panel_width_mm  - lcd_window_width_mm)  / 2;
lcd_window_y0_mm = (panel_height_mm - lcd_window_height_mm) / 2;

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
 * LCD Window Cutout
 *
 * Rectangular through-hole with the 4 Z-parallel (vertical) corners filleted
 * by a 1 mm radius via minkowski() with a short cylinder. The cutout extends
 * 1 mm past the plate on both Z faces so the boolean subtract is clean and
 * no coincident-face slivers remain at Z=0 or Z=T.
 *
 * Note: the front/back face transitions of the cutout are intentionally left
 * at 90 deg. Rounding them (sphere minkowski) caused CSG artifacts because
 * the rounded cutout ends exactly on the plate's face planes.
 */
module lcd_window_cutout() {
    r = corner_radius_mm;
    translate([lcd_window_x0_mm + r, lcd_window_y0_mm + r, -1])
        minkowski() {
            cube([lcd_window_width_mm  - 2 * r,
                  lcd_window_height_mm - 2 * r,
                  panel_thickness_mm + 2]);
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
        }
        lcd_window_cutout();
        lcd_screw_holes();
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
