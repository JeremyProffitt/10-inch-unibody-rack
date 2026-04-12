# Waveshare 7inch HDMI LCD (B) — Reference

Research reference for the **Waveshare 7inch HDMI LCD (B)** — a 7" capacitive-touch HDMI display (800x480) intended to be integrated as a rack-mounted display for this project.

All dimensions are taken directly from the official Waveshare mechanical drawing (see Sources). Use these values as the authoritative source when designing any mount, case, or bezel for this display.

---

## Identification

| Field | Value |
|---|---|
| Product name | 7inch HDMI LCD (B) |
| Vendor | Waveshare |
| Panel resolution | 800 x 480 px |
| Panel type | Capacitive touch, HDMI input |
| Rev (current) | 2.1 (driver-free, HID-compliant) |

---

## Board dimensions (PCB, back view)

| Parameter | Value (mm) |
|---|---|
| PCB outline width | 164.90 |
| PCB outline height | 124.27 |
| Mounting hole spacing, X (center-to-center) | 156.90 |
| Mounting hole spacing, Y (center-to-center) | 114.96 |
| Mounting hole diameter | Ø3.25 (4 holes, M3 clearance, snug) |
| Hole inset from left/right edge | 4.00 |
| Hole inset from top/bottom edge | 4.655 |

### Mounting hole centers (from PCB bottom-left corner)

| Corner | X (mm) | Y (mm) |
|---|---|---|
| Bottom-Left | 4.00 | 4.655 |
| Bottom-Right | 160.90 | 4.655 |
| Top-Left | 4.00 | 119.615 |
| Top-Right | 160.90 | 119.615 |

---

## LCD glass / viewing area (front view)

| Parameter | Value (mm) | Notes |
|---|---|---|
| Lens OD (glass outline) | 164.28 x 99.17 | ±0.1 |
| Viewing Area (VA) | 154.58 x 86.42 | ±0.2, 800x480 px |
| Glass offset from PCB left edge | 8.73 | |
| VA offset inside lens (left) | 3.06 | |
| VA offset inside lens (top) | 4.02 | |

---

## Thickness (side view)

| Parameter | Value (mm) |
|---|---|
| Total module (PCB + glass + components) | 8.3 ±0.3 |
| PCB alone | 1.6 |

---

## Connectors (left edge of PCB)

The left edge of the PCB carries the following, from top to bottom (as seen in the back-view drawing):
- Micro-HDMI input (labeled "Display")
- Micro-USB (touch + power)
- 5V / GND test points
- Backlight on/off switch

Any enclosure must provide clearance on the **left edge of the PCB** for these connectors and cables. The user's rule of thumb for this project is **1 inch (25.4 mm) of cable clearance on each long side** of the display when integrating into a rack.

---

## ASCII diagrams

### Front view (glass / viewing area)

```
        <--------- 164.28 ---------->       (Lens OD)
        <-------- 154.58 --------->         (VA, 800x480 px)
     +---------------------------------+  ^
   ^ |  +---------------------------+  |  |
 4.02| |  |                           | |  |
   v | |  |    VIEWING AREA           | |  | 99.17 (Lens OD)
     | |  |    154.58 x 86.42 mm      | | 86.42 (VA)
     | |  |    (800 x 480 px)         | |  |
     | |  +---------------------------+ |  |
     | +----+------------------------+--+  v
     +------|-- 3.06
            v
```

### PCB back view with mounting holes

```
        <------------ 164.90 ------------>
        <--- 4.00 ---|<-- 156.90 -->|---->
     +--O-----------------------------O--+  ^
     |  |     (TL hole center)        |  |  |
     |  |                             |  |  |
     |  |    +---------------------+  |  |  |
     |  |    |                     |  |  |  | 124.27
     | HDMI  |     PCB features    |  |  |  | (PCB)
     | USB   |     (ICs, FFC)      |  | 114.96
     |  |    |                     |  |  |  |
     |  |    +---------------------+  |  |  |
     |  |                             |  |  |
     +--O-----------------------------O--+  v
      4.655  (BL hole center)  4.655 ^
```

---

## Usage notes for this project

- **Cable clearance**: Reserve 25.4 mm (1") of horizontal clearance on each side of the PCB for cable routing. Total horizontal envelope: `164.90 + 2*25.4 = 215.7 mm`, which fits the 10" rack clear opening (222.25 mm) with ~3.3 mm margin per side.
- **Minimum rack height**: PCB is 124.27 mm tall. Fits in 3U (133.35 mm) with 9 mm margin, or more comfortably in 4U (177.8 mm).
- **Mounting screws**: 4 x M3, 8-10 mm long machine screws are compatible (Ø3.25 mm holes).
- **Print orientation**: Any case must support printing face-down with no supports per project conventions. The viewing window is a simple rectangular cutout; the PCB mounting bosses should be vertical in print.
- **LCD opening in bezel**: Use `156.70 x 89.10 mm` (bezel-open dimension from the panel drawing) as the minimum viewing window size in any bezel. For a visible-active-area window only, use `154.58 x 86.42 mm` (VA).

---

## Sources

- Waveshare Wiki — main product page: https://www.waveshare.com/wiki/7inch_HDMI_LCD_(B)
- Waveshare mechanical drawing (authoritative PCB + glass dimensions): https://files.waveshare.com/wiki/7inch%20HDMI%20LCD%20(B)/7inch%20HDMI%20LCD%20(B).pdf
- Waveshare LCD panel dimension drawing: https://files.waveshare.com/upload/3/34/7inch-hdmi-lcd-b-panel-dimension.pdf
- Waveshare STEP (3D CAD) model: https://files.waveshare.com/wiki/7inch%20HDMI%20LCD%20(B)/7inch%20HDMI%20LCD%20(B).stp
- Waveshare exterior size image: https://www.waveshare.com/img/devkit/LCD/7BP/Exterior-Size.jpg
- User manual PDF: https://www.waveshare.com/w/upload/1/19/7inch_HDMI_LCD_(B)_User_Manual.pdf
