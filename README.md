# 10-Inch Unibody Server Rack

A parametric, unibody 10-inch server rack designed to 3D print in a single piece on the **Bambu Labs H2D**. Prints front-face-down with **zero supports required**.

## Features

- **6U capacity** with standard EIA-310 mounting hole pattern
- **Prints in one piece** - no assembly required
- **No supports needed** - all geometry is self-supporting when printed face-down
- **Rounded exterior edges** for clean aesthetics and handling comfort
- **M6 nut traps** with diamond bevels for captive hardware
- **Grip bars** and filleted handle cutouts for comfortable carrying
- **Open back** for ventilation and cable management
- **Parametric design** - easily adjust rack units, depth, wall thickness

## Designs

### Just a Rack (6U)

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/just-a-rack_front.png) | ![Rear](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/just-a-rack_rear.png) |

Unibody 6U 10-inch server rack with M6 nut traps, 18mm grip bars, filleted handle cutouts, and 30mm deep mounting rails. Prints support-free on the Bambu Labs H2D.

**Download STL**: [just-a-rack.stl](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/just-a-rack.stl)

### Rack with Cubbies (6U)

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/rack-with-cubbies_front.png) | ![Rear](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/rack-with-cubbies_rear.png) |

Same rack with a 55mm cubby extension on the right side featuring horizontal shelves every 4 inches for accessory storage.

**Download STL**: [rack-with-cubbies.stl](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/rack-with-cubbies.stl)

## Print Instructions

1. **Orientation**: Place the front face (Z=0) down on the build plate
2. **Supports**: None needed
3. **Material**: PLA, PETG, or ASA
4. **Infill**: 20-30%
5. **Layer Height**: 0.2mm
6. **Bed Adhesion**: Brim recommended (large footprint)

## Building Locally

### Linux/macOS

```bash
./build.sh
```

### Windows

```batch
generate.bat
```

Output files (STL and PNG) are generated in the `output/` directory.

## References

- [10-inch rack dimensions (Jeff Geerling - Project MINI RACK)](https://mini-rack.jeffgeerling.com/)
- [EIA-310 rack standard (Wikipedia)](https://en.wikipedia.org/wiki/19-inch_rack)
- [Bambu Labs H2D specifications](https://bambulab.com/en-us/h2d/tech-specs)

## License

Open source hardware. See individual files for details.
