"""Generate smoother player walk animations for Blank Pixel Game.

Reads the original walk-cycle frames, creates interpolated in-between frames
by alpha-blending adjacent keyframes, and writes the expanded animation back
into the GameMaker sprite folders.  The original idle sprite
(Gamecharacter_standart) and the source reference image (Gamecharacterman.png)
are left untouched.

Usage (run from repo root):
    python tools/generate_smooth_player.py

Requirements:
    pip install Pillow
"""

from __future__ import annotations

import json
import shutil
import uuid
from pathlib import Path

from PIL import Image

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

REPO_ROOT = Path(__file__).resolve().parents[1]
SPRITES_DIR = REPO_ROOT / "Blank Pixel Game" / "sprites"

# Each entry: (folder_name, number_of_original_frames)
SPRITE_SETS = [
    ("Gamecharacter_nach_rechts_laufen", 12),
    ("Gamecharacter_nach_links_laufen", 12),
    ("Gamecharacter_nach_norden_laufen", 8),
    ("Gamecharacter_nach_sueden_laufen", 8),
]

# Number of interpolated in-between frames to insert between each pair of
# original keyframes.  1 means we add one blend frame between every pair,
# effectively doubling the frame count.
INBETWEEN_COUNT = 1

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _new_uuid() -> str:
    return str(uuid.uuid4())


def _load_frames_sorted(folder: Path) -> list[tuple[str, Image.Image]]:
    """Return (uuid_name, image) pairs sorted by the .yy frame order."""
    import re as _re

    yy_files = list(folder.glob("*.yy"))
    if not yy_files:
        raise FileNotFoundError(f"No .yy file found in {folder}")
    yy_path = yy_files[0]
    with open(yy_path, "r", encoding="utf-8") as fh:
        raw = fh.read()

    # GameMaker .yy uses trailing commas — strip them before JSON parsing.
    # Remove trailing commas before } or ]
    cleaned = _re.sub(r",\s*([}\]])", r"\1", raw)
    data = json.loads(cleaned)

    frame_names: list[str] = [
        entry["name"] for entry in data["frames"]
    ]

    result: list[tuple[str, Image.Image]] = []
    for name in frame_names:
        png = folder / f"{name}.png"
        if not png.exists():
            raise FileNotFoundError(f"Frame image missing: {png}")
        result.append((name, Image.open(png).convert("RGBA")))

    return result


def _blend_images(
    img_a: Image.Image,
    img_b: Image.Image,
    ratio: float = 0.5,
) -> Image.Image:
    """Alpha-aware blend of two RGBA images at the given ratio (0=A, 1=B)."""
    return Image.blend(img_a, img_b, ratio)


def _build_frames_section(
    frame_ids: list[str],
    layer_uuid: str,
) -> str:
    """Build the ``"frames"`` JSON array string (GameMaker format)."""
    lines: list[str] = []
    for fid in frame_ids:
        lines.append(
            '    {"$GMSpriteFrame":"v1",'
            '"%Name":"' + fid + '",'
            '"name":"' + fid + '",'
            '"resourceType":"GMSpriteFrame",'
            '"resourceVersion":"2.0",},'
        )
    return "\n".join(lines)


def _build_keyframes_section(
    frame_ids: list[str],
    sprite_path: str,
) -> str:
    """Build the ``Keyframes`` list inside the sprite-frames track."""
    lines: list[str] = []
    for idx, fid in enumerate(frame_ids):
        kf_id = _new_uuid()
        lines.append(
            '            {"$Keyframe<SpriteFrameKeyframe>":"",'
            '"Channels":{"0":{"$SpriteFrameKeyframe":"",'
            '"Id":{"name":"' + fid + '",'
            '"path":"' + sprite_path + '",'
            '},"resourceType":"SpriteFrameKeyframe","resourceVersion":"2.0",},'
            '},"Disabled":false,"id":"' + kf_id + '",'
            '"IsCreationKey":false,"Key":' + str(idx) + '.0,"Length":1.0,'
            '"resourceType":"Keyframe<SpriteFrameKeyframe>",'
            '"resourceVersion":"2.0","Stretch":false,},'
        )
    return "\n".join(lines)


def _build_yy(
    sprite_name: str,
    frame_ids: list[str],
    layer_uuid: str,
    width: int = 256,
    height: int = 256,
    bbox_top: int = 18,
    bbox_bottom: int = 236,
    bbox_left: int = 78,
    bbox_right: int = 182,
    playback_speed: float = 12.0,
) -> str:
    """Return the full .yy file content for a walking sprite."""
    frame_count = len(frame_ids)
    sprite_path = f"sprites/{sprite_name}/{sprite_name}.yy"
    frames_section = _build_frames_section(frame_ids, layer_uuid)
    keyframes_section = _build_keyframes_section(frame_ids, sprite_path)

    return f"""{{
  "$GMSprite":"v2",
  "%Name":"{sprite_name}",
  "bboxMode":2,
  "bbox_bottom":{bbox_bottom},
  "bbox_left":{bbox_left},
  "bbox_right":{bbox_right},
  "bbox_top":{bbox_top},
  "collisionKind":2,
  "collisionTolerance":0,
  "DynamicTexturePage":false,
  "edgeFiltering":false,
  "For3D":false,
  "frames":[
{frames_section}
  ],
  "gridX":0,
  "gridY":0,
  "height":{height},
  "HTile":false,
  "layers":[
    {{"$GMImageLayer":"","%Name":"{layer_uuid}","blendMode":0,"displayName":"default","isLocked":false,"name":"{layer_uuid}","opacity":100.0,"resourceType":"GMImageLayer","resourceVersion":"2.0","visible":true,}},
  ],
  "name":"{sprite_name}",
  "nineSlice":null,
  "origin":4,
  "parent":{{
    "name":"Player",
    "path":"folders/Sprites/Player.yy",
  }},
  "preMultiplyAlpha":false,
  "resourceType":"GMSprite",
  "resourceVersion":"2.0",
  "sequence":{{
    "$GMSequence":"v1",
    "%Name":"{sprite_name}",
    "autoRecord":true,
    "backdropHeight":768,
    "backdropImageOpacity":0.5,
    "backdropImagePath":"",
    "backdropWidth":1366,
    "backdropXOffset":0.0,
    "backdropYOffset":0.0,
    "events":{{
      "$KeyframeStore<MessageEventKeyframe>":"",
      "Keyframes":[],
      "resourceType":"KeyframeStore<MessageEventKeyframe>",
      "resourceVersion":"2.0",
    }},
    "eventStubScript":null,
    "eventToFunction":{{}},
    "length":{frame_count}.0,
    "lockOrigin":false,
    "moments":{{
      "$KeyframeStore<MomentsEventKeyframe>":"",
      "Keyframes":[],
      "resourceType":"KeyframeStore<MomentsEventKeyframe>",
      "resourceVersion":"2.0",
    }},
    "name":"{sprite_name}",
    "playback":1,
    "playbackSpeed":{playback_speed},
    "playbackSpeedType":0,
    "resourceType":"GMSequence",
    "resourceVersion":"2.0",
    "showBackdrop":true,
    "showBackdropImage":false,
    "timeUnits":1,
    "tracks":[
      {{"$GMSpriteFramesTrack":"","builtinName":0,"events":[],"inheritsTrackColour":true,"interpolation":1,"isCreationTrack":false,"keyframes":{{"$KeyframeStore<SpriteFrameKeyframe>":"","Keyframes":[
{keyframes_section}
          ],"resourceType":"KeyframeStore<SpriteFrameKeyframe>","resourceVersion":"2.0",}},"modifiers":[],"name":"frames","resourceType":"GMSpriteFramesTrack","resourceVersion":"2.0","spriteId":null,"trackColour":0,"tracks":[],"traits":0,}},
    ],
    "visibleRange":null,
    "volume":1.0,
    "xorigin":128,
    "yorigin":128,
  }},
  "swatchColours":null,
  "swfPrecision":0.5,
  "textureGroupId":{{
    "name":"Default",
    "path":"texturegroups/Default",
  }},
  "type":0,
  "VTile":false,
  "width":{width},
}}
"""


# ---------------------------------------------------------------------------
# Main logic
# ---------------------------------------------------------------------------


def process_sprite(sprite_name: str, original_count: int) -> None:
    folder = SPRITES_DIR / sprite_name
    if not folder.is_dir():
        print(f"  SKIP — folder not found: {folder}")
        return

    print(f"  Processing {sprite_name} ({original_count} original frames)…")

    # Read existing frames in .yy order.
    originals = _load_frames_sorted(folder)
    assert len(originals) == original_count, (
        f"Expected {original_count} frames, found {len(originals)} in {folder}"
    )

    # Read the existing .yy to preserve the layer UUID.
    import re as _re
    yy_path = list(folder.glob("*.yy"))[0]
    with open(yy_path, "r", encoding="utf-8") as fh:
        raw = fh.read()
    cleaned = _re.sub(r",\s*([}\]])", r"\1", raw)
    data = json.loads(cleaned)
    layer_uuid = data["layers"][0]["name"]

    # --- Remove old frame PNGs (but keep the .yy and layers/ dir) ----------
    for name, _img in originals:
        old_png = folder / f"{name}.png"
        if old_png.exists():
            old_png.unlink()

    # --- Build new frame list: originals + in-betweens --------------------
    new_frame_ids: list[str] = []
    new_images: dict[str, Image.Image] = {}

    for i, (orig_name, orig_img) in enumerate(originals):
        # Add the original frame with a fresh UUID.
        new_id = _new_uuid()
        new_frame_ids.append(new_id)
        new_images[new_id] = orig_img

        # Generate in-between frames between this frame and the next.
        if i < len(originals) - 1:
            next_name, next_img = originals[i + 1]
            for j in range(1, INBETWEEN_COUNT + 1):
                ratio = j / (INBETWEEN_COUNT + 1)
                blended = _blend_images(orig_img, next_img, ratio)
                tween_id = _new_uuid()
                new_frame_ids.append(tween_id)
                new_images[tween_id] = blended

    # --- Write new frame PNGs ---------------------------------------------
    for fid, img in new_images.items():
        out_path = folder / f"{fid}.png"
        img.save(out_path, "PNG")

    # --- Write updated .yy file -------------------------------------------
    new_total = len(new_frame_ids)
    # Increase playback speed proportionally so the cycle duration stays ~same.
    # Original speed was 10 fps.  With ~2x frames we bump to ~20 fps.
    new_speed = 10.0 * (new_total / original_count)

    yy_content = _build_yy(
        sprite_name=sprite_name,
        frame_ids=new_frame_ids,
        layer_uuid=layer_uuid,
        playback_speed=round(new_speed, 2),
    )
    with open(yy_path, "w", encoding="utf-8") as fh:
        fh.write(yy_content)

    print(
        f"    Done — {original_count} frames → {new_total} frames "
        f"(playback speed {new_speed:.1f} fps)"
    )


def main() -> None:
    print("=== Smooth Player Animation Generator ===\n")
    for sprite_name, count in SPRITE_SETS:
        process_sprite(sprite_name, count)
    print("\nAll done!  Open GameMaker to preview the smoother animations.")


if __name__ == "__main__":
    main()
