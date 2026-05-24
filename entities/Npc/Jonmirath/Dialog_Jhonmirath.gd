extends Node2D

@onready var area = $Area2D

var npc_name = "Jonmirath"
var npc_epiteto = "Senhor das armas"
var npc_idle = "res://Dialog/Assets/Jonmirath/jhon_idle.png"
var npc_angry = "res://Dialog/Assets/Jonmirath/Jhon_angry.png"
var npc_thinking = "res://Dialog/Assets/Jonmirath/jhon_thinking.png"

var player_inside := false
var can_interact := true

var dialog_data := {
	0: {
		"faceset": npc_idle,
		"name": npc_name,
		"epiteto": npc_epiteto,
		"dialog": "Olá garoto, está perdido?"
	},
	1: {
		"faceset": npc_angry,
		"name": npc_name,
		"epiteto": npc_epiteto,
		"dialog": "Isso não é brincadeira, volte para sua terra."
	},
	2: {
		"faceset": npc_thinking,
		"name": npc_name,
		"epiteto": npc_epiteto,
		"dialog": "Sem lar? hmm..."
	}
}

func _ready():

	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _process(_delta):

	if !can_interact:
		return

	if player_inside and Input.is_action_just_pressed("interact"):

		can_interact = false

		var hud = get_tree().get_first_node_in_group("HUD")

		hud.show_dialog(dialog_data)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_inside = true

func _on_body_exited(body):

	if body.is_in_group("Player"):
		player_inside = false
		can_interact = true
