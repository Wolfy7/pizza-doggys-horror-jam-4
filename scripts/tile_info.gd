class_name TileInfo
extends Resource

enum type {BASE, ROCK, SAND, DARKNESS}

@export var tile_type: type = type.BASE
@export var drillable: bool
@export var drill_bit_erosion: int 
@export var breakdown_time: float
