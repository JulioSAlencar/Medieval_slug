extends Control

class_name DialogScreen

var _step: float = 0.02

var _id: int = 0
var data: Dictionary = {}

var _is_writing := false


@export_category("objects")
@export var _name: Label = null
@export var _epiteto: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

func _ready() -> void:

	await get_tree().process_frame

	_initialize_dialog()

func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("ui_accept"):

		# Se ainda está escrevendo
		if _is_writing:

			_dialog.visible_characters = _dialog.text.length()

			_is_writing = false

			return

		# Próxima frase
		_id += 1

		# Terminou diálogo
		if _id >= data.size():

			queue_free()
			return

		_initialize_dialog()

func _initialize_dialog() -> void:

	var dialog_data = data[_id]

	_name.text = dialog_data.name
	_epiteto.text = dialog_data.epiteto
	_dialog.text = dialog_data.dialog
	_faceset.texture = load(dialog_data.faceset)

	_dialog.visible_characters = 0

	_is_writing = true

	while _dialog.visible_characters < _dialog.text.length():

		if !_is_writing:
			break

		await get_tree().create_timer(_step).timeout

		_dialog.visible_characters += 1

	_is_writing = false
