extends CharacterBody2D

@onready var sprite = $PlayerSprite
@onready var legs: AnimatedSprite2D = $PlayerSprite/Legs

@onready var f_arm = $PlayerSprite/Torso/R_Arm
@onready var b_arm = $PlayerSprite/Torso/L_Arm
@onready var hand = $PlayerSprite/Torso/R_Arm/Hand
@onready var aim_pivot = $PlayerSprite/Torso/AimPivot

const WALK_SPEED = 150.0

func _physics_process(_delta: float) -> void:
	_handle_movement()
	_update_animations()

	aim(get_global_mouse_position())

	move_and_slide()

func aim(pos: Vector2):

	_flip_player_sprite(pos.x < global_position.x)

	if pos.x < global_position.x:
		f_arm.rotation = lerp_angle(
			f_arm.rotation,
			-(aim_pivot.global_position - pos).angle(),
			0.10
		)
	else:
		f_arm.rotation = lerp_angle(
			f_arm.rotation,
			(pos - aim_pivot.global_position).angle(),
			0.10
		)

	b_arm.look_at(hand.global_position)

func _flip_player_sprite(flip: bool):

	if flip:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1

func _handle_movement() -> void:

	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * WALK_SPEED
	else:
		velocity.x = 0

func _update_animations() -> void:

	var direction := Input.get_axis("move_left", "move_right")

	# Idle
	if direction == 0:
		legs.play("idle")
		return

	# Para onde o personagem está olhando
	var looking_left: bool = sprite.scale.x < 0

	# Movimento contrário da mira
	var walking_backwards: bool = (
		(looking_left and direction > 0)
		or
		(not looking_left and direction < 0)
	)

	if walking_backwards:
		legs.play("walk_back")
	else:
		legs.play("walk")

func _hited():
	$LifeBar.value -= 20
	if $LifeBar.value <= 0:
		Globals.restart_game()
		
		
		
		
