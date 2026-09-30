"""Generate small, editable pixel-art weapon sprites for Blank Pixel Game.

Uses only the Python standard library. Run from any directory with:
    python tools/generate_weapon_skins.py
"""

from __future__ import annotations

import binascii
import math
import re
import struct
import uuid
import zlib
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
PROJECT = REPO_ROOT / "Blank Pixel Game"
SPRITE_TEMPLATE = PROJECT / "sprites" / "sprite_normal_bullet" / "sprite_normal_bullet.yy"
SIZE = 256


def color(value: str) -> tuple[int, int, int, int]:
	value = value.lstrip("#")
	return (int(value[0:2], 16), int(value[2:4], 16), int(value[4:6], 16), 255)


class Canvas:
	def __init__(self, width: int = SIZE, height: int = SIZE) -> None:
		self.width = width
		self.height = height
		self.pixels = bytearray(width * height * 4)

	def pixel(self, x: int, y: int, fill: tuple[int, int, int, int]) -> None:
		if 0 <= x < self.width and 0 <= y < self.height:
			index = (y * self.width + x) * 4
			self.pixels[index:index + 4] = bytes(fill)

	def rect(self, x1: int, y1: int, x2: int, y2: int, fill: tuple[int, int, int, int]) -> None:
		left, right = sorted((int(x1), int(x2)))
		top, bottom = sorted((int(y1), int(y2)))
		left, right = max(left, 0), min(right, self.width - 1)
		top, bottom = max(top, 0), min(bottom, self.height - 1)
		for y in range(top, bottom + 1):
			for x in range(left, right + 1):
				self.pixel(x, y, fill)

	def line(self, x1: int, y1: int, x2: int, y2: int, fill: tuple[int, int, int, int], width: int = 1) -> None:
		x, y = int(x1), int(y1)
		x2, y2 = int(x2), int(y2)
		dx, dy = abs(x2 - x), abs(y2 - y)
		sx = 1 if x < x2 else -1
		sy = 1 if y < y2 else -1
		err = dx - dy
		brush = max(1, int(width))
		while True:
			self.rect(x - brush // 2, y - brush // 2, x + brush // 2, y + brush // 2, fill)
			if x == x2 and y == y2:
				break
			e2 = err * 2
			if e2 > -dy:
				err -= dy
				x += sx
			if e2 < dx:
				err += dx
				y += sy

	def polygon(self, points: list[tuple[int, int]], fill: tuple[int, int, int, int], outline: tuple[int, int, int, int] | None = None) -> None:
		if len(points) < 3:
			return
		min_y = max(0, min(y for _, y in points))
		max_y = min(self.height - 1, max(y for _, y in points))
		for y in range(min_y, max_y + 1):
			crossings: list[float] = []
			for index, (x1, y1) in enumerate(points):
				x2, y2 = points[(index + 1) % len(points)]
				if y1 == y2 or y < min(y1, y2) or y >= max(y1, y2):
					continue
				crossings.append(x1 + (y - y1) * (x2 - x1) / (y2 - y1))
			crossings.sort()
			for index in range(0, len(crossings) - 1, 2):
				left = max(0, math.ceil(crossings[index]))
				right = min(self.width - 1, math.floor(crossings[index + 1]))
				for x in range(left, right + 1):
					self.pixel(x, y, fill)
		if outline:
			for index, (x1, y1) in enumerate(points):
				x2, y2 = points[(index + 1) % len(points)]
				self.line(x1, y1, x2, y2, outline, 2)

	def ellipse(self, cx: int, cy: int, rx: int, ry: int, fill: tuple[int, int, int, int]) -> None:
		for y in range(max(0, cy - ry), min(self.height, cy + ry + 1)):
			for x in range(max(0, cx - rx), min(self.width, cx + rx + 1)):
				if ((x - cx) / max(1, rx)) ** 2 + ((y - cy) / max(1, ry)) ** 2 <= 1:
					self.pixel(x, y, fill)

	def png_bytes(self) -> bytes:
		def chunk(kind: bytes, data: bytes) -> bytes:
			body = kind + data
			return struct.pack(">I", len(data)) + body + struct.pack(">I", binascii.crc32(body) & 0xFFFFFFFF)

		raw = b"".join(b"\x00" + self.pixels[y * self.width * 4:(y + 1) * self.width * 4] for y in range(self.height))
		return (
			b"\x89PNG\r\n\x1a\n"
			+ chunk(b"IHDR", struct.pack(">IIBBBBB", self.width, self.height, 8, 6, 0, 0, 0))
			+ chunk(b"IDAT", zlib.compress(raw, 9))
			+ chunk(b"IEND", b"")
		)


INK = color("#091321")
STEEL = color("#273b50")
STEEL_LIGHT = color("#526b80")
STEEL_DARK = color("#172638")
CYAN = color("#34e6f4")
PINK = color("#ff4eaa")
GOLD = color("#e7ae55")
RUBBER = color("#20283a")


def draw_usp_s(c: Canvas) -> None:
	# Suppressor and threaded barrel.
	c.rect(53, 63, 250, 96, INK)
	c.rect(57, 67, 246, 92, STEEL)
	c.rect(68, 70, 236, 74, STEEL_LIGHT)
	c.rect(74, 77, 235, 88, STEEL_DARK)
	c.rect(89, 68, 218, 70, CYAN)
	c.rect(228, 66, 237, 91, CYAN)
	c.rect(242, 69, 248, 90, INK)

	# Slide, receiver, sights and trigger guard.
	c.polygon([(38, 78), (169, 76), (183, 84), (186, 108), (166, 117), (62, 113), (47, 103)], STEEL, INK)
	c.polygon([(45, 81), (164, 80), (173, 86), (171, 94), (54, 96)], STEEL_LIGHT)
	c.rect(58, 98, 163, 102, CYAN)
	c.rect(69, 83, 76, 89, INK)
	c.rect(153, 82, 161, 87, INK)
	c.rect(78, 73, 92, 79, INK)
	c.rect(141, 73, 155, 79, INK)
	c.rect(45, 100, 61, 105, STEEL_DARK)
	c.line(114, 109, 140, 113, INK, 4)
	c.line(140, 113, 139, 133, INK, 4)
	c.line(139, 133, 119, 134, INK, 4)
	c.line(117, 112, 117, 128, GOLD, 2)
	c.rect(145, 103, 155, 110, PINK)

	# Textured grip with a cyan heel plate.
	c.polygon([(69, 106), (116, 109), (111, 147), (104, 188), (86, 204), (64, 187), (59, 158)], RUBBER, INK)
	c.polygon([(74, 119), (105, 121), (100, 176), (87, 190), (72, 177)], STEEL_DARK)
	for y in (132, 142, 152, 162, 172):
		c.line(70, y, 98, y + 2, STEEL_LIGHT, 2)
	c.rect(65, 181, 90, 189, CYAN)
	c.rect(81, 125, 96, 130, PINK)


def draw_glock(c: Canvas) -> None:
	# Polymer frame and slide.
	c.polygon([(47, 79), (191, 77), (210, 84), (207, 101), (177, 108), (68, 106), (53, 99)], INK)
	c.polygon([(52, 82), (190, 81), (202, 86), (199, 96), (64, 98), (55, 94)], STEEL_LIGHT)
	c.rect(62, 99, 188, 104, CYAN)
	c.rect(73, 84, 83, 89, INK)
	c.rect(167, 83, 177, 88, INK)
	c.rect(201, 84, 207, 98, STEEL_DARK)
	c.ellipse(205, 90, 2, 3, INK)

	c.polygon([(53, 97), (174, 101), (183, 109), (163, 122), (145, 126), (134, 181), (116, 203), (91, 192), (77, 165), (78, 121), (59, 115)], RUBBER, INK)
	c.polygon([(64, 110), (101, 113), (99, 182), (89, 175), (84, 158), (85, 121)], STEEL_DARK)
	for y in (129, 139, 149, 159, 169):
		c.line(82, y, 101, y + 3, STEEL_LIGHT, 2)
	c.rect(89, 184, 115, 192, PINK)
	c.rect(126, 106, 151, 110, GOLD)
	c.line(118, 112, 141, 115, INK, 4)
	c.line(141, 115, 140, 135, INK, 4)
	c.line(140, 135, 121, 135, INK, 4)
	c.line(120, 115, 120, 130, CYAN, 2)
	c.rect(59, 72, 70, 80, PINK)
	c.rect(178, 72, 188, 80, PINK)


def draw_makarov(c: Canvas) -> None:
	# Compact slide with a warm, custom grip panel.
	c.polygon([(55, 79), (176, 77), (194, 83), (192, 101), (169, 107), (70, 105), (57, 97)], INK)
	c.polygon([(61, 82), (174, 81), (185, 85), (184, 96), (68, 97), (62, 93)], STEEL)
	c.rect(68, 97, 177, 101, CYAN)
	c.rect(79, 84, 88, 89, INK)
	c.rect(154, 82, 165, 87, INK)
	c.rect(186, 84, 192, 96, STEEL_DARK)
	c.ellipse(190, 90, 2, 3, INK)

	c.polygon([(59, 97), (164, 101), (174, 111), (157, 121), (137, 124), (128, 168), (111, 188), (88, 181), (75, 158), (77, 119), (62, 113)], RUBBER, INK)
	c.polygon([(78, 119), (112, 120), (106, 169), (94, 175), (82, 157)], color("#805334"))
	c.line(83, 129, 105, 132, GOLD, 3)
	c.line(81, 140, 103, 143, GOLD, 3)
	c.line(79, 151, 100, 154, GOLD, 3)
	c.rect(87, 173, 110, 180, PINK)
	c.line(112, 109, 135, 112, INK, 4)
	c.line(135, 112, 133, 130, INK, 4)
	c.line(133, 130, 116, 131, INK, 4)
	c.line(114, 112, 114, 126, CYAN, 2)
	c.rect(65, 72, 76, 79, CYAN)
	c.rect(157, 73, 168, 79, PINK)


def draw_ak47(c: Canvas) -> None:
	wood = color("#9a6337")
	wood_light = color("#c48b4b")
	green = color("#45604a")

	# Stock, receiver, barrel and front handguard.
	c.polygon([(7, 82), (66, 82), (77, 91), (73, 106), (61, 115), (14, 109), (6, 101)], INK)
	c.polygon([(13, 86), (62, 86), (69, 92), (66, 101), (58, 108), (17, 103)], wood)
	c.line(18, 92, 59, 94, wood_light, 3)
	c.polygon([(58, 79), (157, 78), (177, 87), (178, 117), (159, 130), (75, 124), (59, 108)], INK)
	c.polygon([(64, 83), (153, 82), (169, 89), (170, 111), (156, 122), (77, 118), (65, 105)], STEEL)
	c.rect(74, 86, 152, 90, STEEL_LIGHT)
	c.rect(82, 93, 150, 97, CYAN)
	c.rect(77, 105, 161, 111, STEEL_DARK)
	c.rect(118, 82, 131, 88, PINK)

	c.polygon([(157, 81), (194, 82), (202, 91), (198, 106), (161, 106), (153, 98)], green, INK)
	for y in (88, 94, 100):
		c.line(163, y, 194, y, wood_light, 2)
	c.rect(190, 86, 245, 96, STEEL_DARK)
	c.rect(198, 88, 239, 92, STEEL_LIGHT)
	c.rect(238, 83, 250, 100, INK)
	c.rect(242, 87, 248, 96, CYAN)

	# Curved magazine and pistol grip.
	c.polygon([(112, 118), (145, 121), (152, 153), (148, 181), (132, 194), (119, 177), (116, 148)], INK)
	c.polygon([(118, 123), (139, 126), (145, 153), (141, 175), (132, 185), (124, 171), (121, 147)], color("#374d40"))
	c.line(123, 132, 139, 134, STEEL_LIGHT, 2)
	c.line(124, 145, 142, 147, STEEL_LIGHT, 2)
	c.line(126, 159, 142, 161, STEEL_LIGHT, 2)
	c.polygon([(77, 113), (111, 115), (108, 161), (95, 176), (80, 165), (73, 137)], INK)
	c.polygon([(82, 118), (105, 119), (102, 155), (94, 166), (84, 158), (79, 137)], wood)
	c.line(84, 128, 101, 130, wood_light, 2)
	c.line(82, 140, 99, 142, wood_light, 2)
	c.line(110, 117, 132, 120, INK, 4)
	c.line(132, 120, 131, 139, INK, 4)
	c.line(131, 139, 114, 137, INK, 4)
	c.line(112, 120, 112, 134, GOLD, 2)
	c.rect(91, 109, 113, 114, CYAN)


WEAPONS = [
	{
		"name": "spr_weapon_usps",
		"draw": draw_usp_s,
		"origin": (86, 146),
		"muzzle": (247, 78),
		"scale": 0.15,
	},
	{
		"name": "spr_weapon_glock",
		"draw": draw_glock,
		"origin": (95, 147),
		"muzzle": (207, 83),
		"scale": 0.17,
	},
	{
		"name": "spr_weapon_makarov",
		"draw": draw_makarov,
		"origin": (89, 139),
		"muzzle": (192, 84),
		"scale": 0.17,
	},
	{
		"name": "spr_weapon_ak47",
		"draw": draw_ak47,
		"origin": (112, 145),
		"muzzle": (249, 89),
		"scale": 0.21,
	},
]


def write_sprite_resource(weapon: dict[str, object]) -> None:
	name = str(weapon["name"])
	frame_id = str(uuid.uuid5(uuid.NAMESPACE_URL, f"game-schule/{name}/frame"))
	layer_id = str(uuid.uuid5(uuid.NAMESPACE_URL, f"game-schule/{name}/layer"))
	keyframe_id = str(uuid.uuid5(uuid.NAMESPACE_URL, f"game-schule/{name}/keyframe"))
	origin_x, origin_y = weapon["origin"]  # type: ignore[misc]

	c = Canvas()
	weapon["draw"](c)  # type: ignore[operator]

	resource_dir = PROJECT / "sprites" / name
	layer_dir = resource_dir / "layers" / frame_id
	layer_dir.mkdir(parents=True, exist_ok=True)
	png = c.png_bytes()
	(resource_dir / f"{frame_id}.png").write_bytes(png)
	(layer_dir / f"{layer_id}.png").write_bytes(png)

	template = SPRITE_TEMPLATE.read_text(encoding="utf-8-sig")
	template = template.replace("sprite_normal_bullet", name)
	template = template.replace("a23a7511-0862-41dd-84bd-03128dcade77", frame_id)
	template = template.replace("081216f2-f609-4663-8bc4-5af4d199a6ec", layer_id)
	template = template.replace("7991abfe-afbc-44c4-8cc0-93f3062d8e1c", keyframe_id)
	for key, value in {
		"bbox_bottom": SIZE - 1,
		"bbox_left": 0,
		"bbox_right": SIZE - 1,
		"bbox_top": 0,
		"height": SIZE,
		"width": SIZE,
		"origin": 9,
		"xorigin": origin_x,
		"yorigin": origin_y,
	}.items():
		template = re.sub(rf'("{key}":)\d+', rf'\g<1>{value}', template)
	(resource_dir / f"{name}.yy").write_text(template, encoding="utf-8")


def main() -> None:
	if not SPRITE_TEMPLATE.exists():
		raise FileNotFoundError(f"GameMaker sprite template was not found: {SPRITE_TEMPLATE}")
	for weapon in WEAPONS:
		write_sprite_resource(weapon)
		print(f"Generated {weapon['name']}")


if __name__ == "__main__":
	main()
