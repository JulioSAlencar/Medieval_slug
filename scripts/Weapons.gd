extends Node2D

@onready var pistol = $Pistol
@onready var shotgun = $Shotgun
@onready var ak = $AK

@onready var l_arm = $"../../../L_Arm"


var current_weapon := "pistol"

const BULLET = preload("res://entities/Player/bullet.tscn")

func equip_weapon(weapon_name: String) -> void:

	current_weapon = weapon_name

	pistol.visible = false
	shotgun.visible = false
	ak.visible = false

	match weapon_name:

		"pistol":
			pistol.visible = true

		"shotgun":
			shotgun.visible = true

		"ak":
			ak.visible = true

func shoot() -> void:

	var weapon_node: Node2D
	var bullet_anim := "Fire_1"

	match current_weapon:

		"pistol":
			weapon_node = pistol
			bullet_anim = "Fire_2"

		"shotgun":
			weapon_node = shotgun
			bullet_anim = "Fire_1"

		"ak":
			weapon_node = ak
			bullet_anim = "Fire_2"

	var muzzle = weapon_node.get_node("Muzzle")

	var bullet_instance = BULLET.instantiate()
	bullet_instance.owner_type = "player"       # ← ADICIONE ISSO
	bullet_instance.set_name("PlayerBullet_" + str(Time.get_ticks_msec()))
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.global_rotation = muzzle.global_rotation
	bullet_instance.set_bullet_animation(bullet_anim)

func _input(event):

	if event.is_action_pressed("fire"):
		shoot()

	if event.is_action_pressed("weapon_1"):
		equip_weapon("pistol")
		l_arm.position = Vector2(-1, -3)

	if event.is_action_pressed("weapon_2"):
		equip_weapon("shotgun")
		l_arm.position = Vector2(2, -1)

	if event.is_action_pressed("weapon_3"):
		equip_weapon("ak")
		l_arm.position = Vector2(2, -1)

func _ready() -> void:
	equip_weapon("pistol")
