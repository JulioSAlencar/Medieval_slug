extends CanvasLayer

@export var dialog_scene: PackedScene

var current_dialog = null

func show_dialog(dialog_data: Dictionary) -> void:
	if current_dialog:
		current_dialog.queue_free()

	current_dialog = dialog_scene.instantiate()

	add_child(current_dialog)

	current_dialog.data = dialog_data
