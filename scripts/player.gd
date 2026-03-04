extends Area2D

var tile_size: int = 32
var inputs: Dictionary = {"right": Vector2.RIGHT,
							"left": Vector2.LEFT,
							"up": Vector2.UP,
							"down": Vector2.DOWN}
var facing: Vector2 = Vector2.RIGHT
var animation_speed: int = 3
var moving: bool = false
var drilling: bool = false
var current_tile: Vector2i 
var facing_tile: Vector2i:
	set(tile):
		facing_tile = tile
		var tile_info: TileInfo = tile_map_layer.get_tile_info(facing_tile)
		if tile_info && tile_info.drillable: 
			animated_sprite_2d.show()
		else:
			animated_sprite_2d.hide()

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var camera_2d: Camera2D = $Camera2D
@onready var speech_bubble: MarginContainer = $SpeechBubble
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var drill_particle: DrillParticle
@export var animated_sprite_2d: AnimatedSprite2D


func set_facing(new_value) -> void:
	facing = new_value
	current_tile = tile_map_layer.local_to_map(position)
	facing_tile = tile_map_layer.local_to_map(position + facing * tile_size)

	
	# TODO
	if facing == Vector2.RIGHT:
		sprite_2d.rotation_degrees = 0.0
	elif facing == Vector2.DOWN:
		sprite_2d.rotation_degrees = 90.0
	elif facing == Vector2.LEFT:
		sprite_2d.rotation_degrees = 180
	elif facing == Vector2.UP:
		sprite_2d.rotation_degrees= 270

func _ready() -> void:
	set_facing(facing)

	
func _unhandled_input(event: InputEvent) -> void:
	if moving or drilling:
		return
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			set_facing(inputs[direction])
			move(direction)
	
	if event.is_action_pressed("drill"):	
		var tile_info: TileInfo = tile_map_layer.get_tile_info(facing_tile)
		if tile_info && tile_info.drillable: 
			drilling = true
			drill_particle.activate()
			camera_2d.start_shake(2, 1)
			await get_tree().create_timer(tile_info.breakdown_time).timeout
			tile_map_layer.delete_tile(facing_tile)
			drill_particle.deactivate()
			facing_tile = facing_tile
			drilling = false
		else:
			# TODO
			speech_bubble._on_event_received("Hier kann ich nicht bohren", 5)
			

func move(direction: String) -> void:
	if not tile_map_layer.can_move_to(facing_tile):
		return
	#position += inputs[direction] * tile_size
	var tween = create_tween()
	tween.tween_property(self, "position", position + inputs[direction] * tile_size, 1.0 / animation_speed). set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
	
	current_tile = tile_map_layer.local_to_map(position)
	facing_tile = tile_map_layer.local_to_map(position + facing * tile_size)
	
