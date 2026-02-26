class_name DrillParticle
extends Node2D

@onready var smoke_particels: GPUParticles2D = $SmokeParticels
@onready var chunks_particles: GPUParticles2D = $ChunksParticles


func activate() -> void:
	smoke_particels.emitting = true
	chunks_particles.emitting = true

func deactivate() -> void:
	smoke_particels.emitting = false
	chunks_particles.emitting = false
	
func set_chunk_color(color: Color) -> void:
	chunks_particles.process_material.color = color
