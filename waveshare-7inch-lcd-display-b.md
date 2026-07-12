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
| VA offset inside lens (bottom) | 8.73 | Derived from lens/VA heights |
| VA offset inside lens (left) | 3.06 | |
| VA offset inside lens (top) | 4.02 | |

---

## Thickness (side view)

| Parameter | Value (mm) |
|---|---|
| Total module (PCB + glass + components) | 8.3 ±0.3 |
| PCB alone | 1.6 |

---

## Connectors (right edge when installed)

The official mechanical drawing is a **back view**, where the connectors appear
on the PCB's left edge. From the installed front/viewer side they are on the
**right edge**, matching the orientation used by the case designs.

That edge carries the following, from top to bottom in the back-view drawing:
- Full-size HDMI Type-A input (labeled "Display")
- Micro-USB (touch and power)
- 5V / GND test points
- Backlight on/off switch

### Connector centerlines

The official assembly drawing dimensions the connector/switch centerlines from
the PCB top edge. The source panel centers the PCB at Y=4.54..128.81 mm:

| Feature | Down from PCB top (mm) | Source-panel Y (mm) |
|---|---:|---:|
| HDMI Type-A center | 21.18 | 107.63 |
| Micro-USB center | 40.18 | 88.63 |
| Backlight switch center | 53.88 | 74.93 |

The cases reserve source-panel Y=70.00..122.00 mm for the connector envelope
and keep 25.40 mm of internal lid space beyond the connector edge. The
Raspberry Pi mounts separately to the solid base floor behind the LCD plane,
not in that lid region. These are clearance envelopes rather than exact
connector-body dimensions; verify unusually large straight plugs against the
physical display revision.

Any enclosure must provide at least **1 inch (25.4 mm) of clear cable space on
the installed right side**. Rotating the LCD 90 degrees counter-clockwise for
portrait use moves this physical connector edge to the installed top, so the
portrait cases provide a separate top chase while retaining the requested
right-side bay.

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

- **Cable clearance**: Reserve at least 25.4 mm (1") beyond the installed right
  connector edge. The new cases provide 25.4 mm of clear space plus a 5 mm
  outer wall beyond the compatible 254 mm source-panel boundary.
- **Minimum rack height**: PCB is 124.27 mm tall. Fits in 3U (133.35 mm) with 9 mm margin, or more comfortably in 4U (177.8 mm).
- **Mounting screws**: 4 x M3, 8-10 mm long machine screws are compatible (Ø3.25 mm holes).
- **Print orientation**: Any case must support printing face-down with no supports per project conventions. The viewing window is a simple rectangular cutout; the PCB mounting bosses should be vertical in print.
- **LCD opening in bezel**: The vendor bezel-open dimension is
  `156.70 x 89.10 mm`; visible active area is `154.58 x 86.42 mm`. The existing
  rack panel and the four compatible case designs intentionally preserve the
  repository's earlier `156.00 x 89.00 mm` back opening with a 3 mm front
  bevel. Increase the shared case constants if exact vendor bezel-open size is
  preferred over compatibility with the existing panel geometry.

---

## Sources

- Waveshare Wiki — main product page: https://www.waveshare.com/wiki/7inch_HDMI_LCD_(B)
- Waveshare mechanical drawing (authoritative PCB + glass dimensions): https://files.waveshare.com/wiki/7inch%20HDMI%20LCD%20(B)/7inch%20HDMI%20LCD%20(B).pdf
- Waveshare LCD panel dimension drawing: https://files.waveshare.com/upload/3/34/7inch-hdmi-lcd-b-panel-dimension.pdf
- Waveshare STEP (3D CAD) model: https://files.waveshare.com/wiki/7inch%20HDMI%20LCD%20(B)/7inch%20HDMI%20LCD%20(B).stp
- Waveshare exterior size image: https://www.waveshare.com/img/devkit/LCD/7BP/Exterior-Size.jpg
- User manual PDF: https://www.waveshare.com/w/upload/1/19/7inch_HDMI_LCD_(B)_User_Manual.pdf
