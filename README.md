# CalcSX Bobbin Exporter for Fusion 360

Exports groove channel geometry from a Fusion 360 bobbin model into a `.bobsx` file that CalcSX can import directly. Each selected groove face becomes an individual channel with exact centerline coordinates and surface normals sampled from Fusion's CAD kernel.

## Install

### Option A — One-click installer (recommended)

1. Download the latest release zip from the [Releases page](../../releases/latest).
2. Unzip it.
3. Run the installer for your OS:
   - **macOS:** double-click `install-macos.command`
     (If macOS blocks it, right-click → **Open**, then confirm.)
   - **Windows:** double-click `install-windows.bat`
4. Restart Fusion 360 if it was running.

The installer copies the script into Fusion's `API/Scripts` directory automatically.

### Option B — Manual install

1. Download or clone this repository.
2. Copy the `calcsx_exporter/` folder into Fusion 360's Scripts directory:
   - **macOS:** `~/Library/Application Support/Autodesk/Autodesk Fusion 360/API/Scripts/`
   - **Windows:** `%APPDATA%\Autodesk\Autodesk Fusion 360\API\Scripts\`
3. Restart Fusion 360.

Either install path makes the script appear under **UTILITIES → Scripts and Add-Ins → My Scripts → calcsx_exporter**.

## Usage

1. Open your bobbin model in Fusion 360.
2. Go to **UTILITIES → Scripts and Add-Ins → My Scripts → calcsx_exporter → Run**.
3. A command dialog appears — select all groove floor faces:
   - Click a groove face to select it.
   - Hold **Ctrl** (Windows) or **Cmd** (Mac) to select additional faces.
   - Each face becomes one channel in the output.
4. Set **Points per channel** (default 500 — higher = smoother centerline).
5. Click **OK**.
6. Choose a save location — the file is saved as `.bobsx`.

## In CalcSX

1. Click **Import Bobbin** (⬡) in the SIMULATION ribbon.
2. Select your `.bobsx` file.
3. Each channel appears as a separate coil that can be:
   - Shown/hidden via the eye toggle in the browser panel.
   - Deleted individually.
   - Analyzed independently or as part of a multi-coil superposition.

## What Gets Exported

- **Channels:** one per selected face. Each contains 3D centerline points with exact surface normals evaluated from the parametric CAD surface (not the tessellation mesh).
- **Bobbin mesh** (optional): a triangulated display mesh of the bobbin body for visual context in CalcSX. Not used for physics calculations.

## File Format

The `.bobsx` file is JSON:

```json
{
  "version": 1,
  "unit": "cm",
  "channels": [
    {
      "name": "groove_1",
      "points": [
        {"x": 1.0, "y": 2.0, "z": 3.0, "nx": 0.0, "ny": 0.0, "nz": 1.0}
      ]
    }
  ],
  "bobbin_mesh": {
    "vertices": [[x, y, z], ...],
    "faces": [[i, j, k], ...]
  }
}
```

Coordinates are in centimeters (Fusion's internal unit). CalcSX converts to metres on import.

## Repository Layout

```
calcsx_exporter/         Fusion 360 script package (drop into API/Scripts/)
  calcsx_exporter.py     Main script
  calcsx_exporter.manifest
install/                 Per-OS installers shipped in the release zip
  install-macos.command
  install-windows.bat
  INSTALL.txt
.github/workflows/       Release automation
```

## Cutting a Release

Push a `v*` tag and the release workflow builds and publishes the installer zip:

```
git tag v1.0.0
git push origin v1.0.0
```

The resulting `calcsx_exporter-v1.0.0.zip` is attached to the GitHub Release and is what CalcSX's "Download Fusion 360 exporter" link should point at (`/releases/latest`).

## Requirements

- Fusion 360 (any recent version).
- No additional Python packages — the script uses only Fusion's built-in API.
