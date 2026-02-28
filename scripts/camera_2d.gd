extends Camera2D

var shake_time := 0.0
var shake_strength := 0.0

func start_shake(duration: float, strength: float) -> void:
	shake_time = duration
	shake_strength = strength

func _process(delta: float) -> void:
	if shake_time > 0:
		shake_time -= delta
		var offset = Vector2(randf_range(-1,1), randf_range(-1,1)) * shake_strength
		offset *= shake_time
		position = offset
	else:
		position = Vector2.ZERO
