extends CanvasLayer

@onready var pause_menu: CanvasLayer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.visible = false
	get_tree().paused = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Escape"):
		if get_tree().paused:
			pause_menu.visible = false
			get_tree().paused = false
		else:
			pause_menu.visible = true
			get_tree().paused = true

func _on_button_pressed() -> void:
	pause_menu.visible = false
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	get_tree().quit()
