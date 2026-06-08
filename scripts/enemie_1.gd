extends Node2D

const BULLET = preload("res://entities/Player/bullet.tscn")

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		$Exclamation.visible = true
		if $Timer.is_stopped():
			$Timer.start()
	else:
		$Exclamation.visible = false
		if not $Timer.is_stopped():
			$Timer.stop()
		# volta para idle se não está vendo o player
		if sprite.animation == "shot_1":
			sprite.play("idle")

func _shoot() -> void:
	sprite.play("shot_1")
	var bullet = BULLET.instantiate()
	bullet.owner_type = "enemy"
	bullet.set_name("EnemyBullet_" + str(Time.get_ticks_msec()))
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = $Muzzle.global_position
	bullet.global_rotation = $Muzzle.global_rotation

func _on_timer_timeout() -> void:
	_shoot()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.has_method("_hited") and parent == self:
		return  # ignora a si mesmo
	if "Bullet" in parent.name or "bullet" in parent.name:
		_hited(area)

func _hited(a):
	a.get_parent().queue_free()
	$LifeBar.value -= 20
	if $LifeBar.value <= 0:
		queue_free()		

func _on_animated_sprite_2d_animation_finished() -> void:

	if sprite.animation == "shot_1":
		sprite.play("idle")
