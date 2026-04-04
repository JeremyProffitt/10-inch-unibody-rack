# 10-Inch Unibody Server Rack

A parametric, unibody 10-inch server rack designed to 3D print in a single piece on the **Bambu Labs H2D**. Prints front-face-down with **zero supports required**.

## Features

- **6U capacity** with standard EIA-310 mounting hole pattern
- **Prints in one piece** - no assembly required
- **No supports needed** - all geometry is self-supporting when printed face-down
- **Rounded exterior edges** for clean aesthetics and handling comfort
- **Handle cutouts** on both sides for easy carrying
- **Open back** for ventilation and cable management
- **Parametric design** - easily adjust rack units, depth, wall thickness

## Specifications

| Parameter | Value |
|-----------|-------|
| Rack Units | 6U |
| Panel Width | 254mm (10") |
| Outer Dimensions | 264 x 276.7 x 200mm |
| Wall Thickness | 5mm |
| Mount Holes | M6 / #12-24 clearance (6.5mm) |
| Hole Spacing | EIA-310 standard |
| Print Footprint | 264 x 276.7mm |

## Designs

### Rack (6U)

| Front View | Rear View |
|------------|-----------|
| ![Front](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/rack_front.png) | ![Rear](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/rack_rear.png) |

Unibody 6U 10-inch server rack with rounded edges and side handle cutouts. Designed for support-free FDM printing on the Bambu Labs H2D.

**Documentation**: [rack.md](rack.md)

**Download STL**: [rack.stl](https://github.com/JeremyProffitt/10-inch-unibody-rack/releases/latest/download/rack.stl)

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
