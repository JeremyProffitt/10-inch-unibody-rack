# Raspberry Pi 4/5 Mechanical Reference

Mechanical reference for mounting a Raspberry Pi 4 Model B or Raspberry Pi 5
behind the Waveshare LCD cases in this repository. Both boards share the board
outline and four-hole mounting pattern used by the case generator.

## Shared Board Pattern

| Parameter | Value (mm) |
|---|---:|
| Board outline | 85.00 x 56.00 |
| Mounting-hole pitch | 58.00 x 49.00 |
| Mounting-hole nominal diameter | 2.70 |
| First-hole inset from left/bottom | 3.50 x 3.50 |

Hole centers from the board bottom-left corner are `(3.5, 3.5)`,
`(61.5, 3.5)`, `(3.5, 52.5)`, and `(61.5, 52.5)` mm.

## Port Edges

With the board component side facing the viewer and the GPIO header along the
top long edge:

- USB and Ethernet connectors occupy the right short edge.
- USB-C power and micro-HDMI video connectors occupy the bottom long edge.
- The microSD card is reached from the opposite short edge.

The closed cases keep this standard orientation on the solid floor:
USB/Ethernet faces the right wall, while power and micro-HDMI face the front
wall. Cable cords drop into 10 mm open-top wall notches before the lid is fitted,
so plug shells remain inside and do not need to pass through a drilled hole.

## Mounting Notes

- The printed bosses use 2.20 mm blind pilot holes for M2.5 self-tapping screws.
- The board plane is 14.00 mm behind the case front, leaving 9.00 mm below it.
- Removing the lid provides service access to GPIO, microSD, ports, and cooler.
- The enclosure is closed; confirm the selected Pi load and cooler do not require
  additional ventilation before long unattended operation.
- Verify an installed HAT, active cooler, or unusually large plug against the
  x-ray render before committing to a full-size print.

## Sources

- [Raspberry Pi 4 Model B mechanical drawing](https://pip.raspberrypi.com/categories/559-mechanical)
- [Raspberry Pi 5 mechanical drawing](https://datasheets.raspberrypi.com/rpi5/raspberry-pi-5-mechanical-drawing.pdf)
- [Raspberry Pi hardware documentation](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#schematics-and-mechanical-drawings)
