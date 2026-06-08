extends Node2D
@onready var animated_sprite = $AnimatedSprite2D

var owner_type := "player"  # "player" ou "enemy"

func set_bullet_animation(anim_name: String) -> void:
	animated_sprite.play(anim_name)
	
const SPEED := 600.0
const LIFE_TIME := 2.0

func _ready() -> void:
	await get_tree().create_timer(LIFE_TIME).timeout
	queue_free()

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	
func _on_area_2d_body_entered(body):
	if owner_type == "enemy" and body is CharacterBody2D and body.has_method("_hited"):
		print("Acertou o player!")
		body._hited()
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if owner_type == "player":
		# detecta inimigo (que usa Area2D)
		var parent = area.get_parent()
		if parent.has_method("_hited"):
			parent._hited(self.get_node("Area2D") if get_node_or_null("Area2D") else area)
			queue_free()
			
			
