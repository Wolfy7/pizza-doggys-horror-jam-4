extends Area2D

var tile_size: int = 32
var inputs: Dictionary = {"right": Vector2.RIGHT,
							"left": Vector2.LEFT,
							"up": Vector2.UP,
							"down": Vector2.DOWN}

var animation_speed: int = 3
var moving: bool = false

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"


func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			move(direction)
			

func move(direction: String) -> void:
	print(position)
	print(tile_map_layer.local_to_map(position))
	
	#position += inputs[direction] * tile_size
	var tween = create_tween()
	tween.tween_property(self, "position", position + inputs[direction] * tile_size, 1.0 / animation_speed). set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
	var tile = tile_map_layer.local_to_map(position)
	print(tile_map_layer.get_cell_atlas_coords(tile) )
