extends Node2D

const SPEED := 600.0
const LIFE_TIME := 2.0

func _ready() -> void:
	await get_tree().create_timer(LIFE_TIME).timeout
	queue_free()

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
