extends Camera2D

var target: CharacterBody2D

func _ready() -> void:
	make_current()
	get_target()

func _physics_process(_delta: float) -> void:
	if target:
		global_position = target.global_position

func get_target() -> void:
	var nodes = get_tree().get_nodes_in_group("Player")

	if nodes.size() == 0:
		push_error("Player not found!")
		return

	target = nodes[0]
