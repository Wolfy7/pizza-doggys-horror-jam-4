@tool
class_name  FlipSprite2D
extends Node

@export var sprite: Node2D:
	set(node_2):
		sprite = node_2
		update_configuration_warnings()
		
@export var flip_h: bool = true
@export var flip_v: bool = false

func _get_configuration_warnings() -> PackedStringArray:
	if not sprite:
		return ["FlipSprite2D needs to have a sprite target set to work!"]
	elif not sprite is Sprite2D and not sprite is AnimatedSprite2D:
		return ["The sprite target is neither a Sprite2D nor an AnimateSprite2D!"]
	else:
		return []

func flip_sprite_towards(other_position: Vector2) -> void:
	var new_dir: Vector2 = sprite.global_position.direction_to(other_position)
	
	if flip_h and sign(new_dir.x) != 0:
		sprite.flip_h = sign(new_dir.x) == 1
	if flip_v and sign(new_dir.y) != 0:
		sprite.flip_v = sign(new_dir.y) == -1
