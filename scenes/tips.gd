extends Node2D

@onready var tip: Area2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tip_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Entered tip area")
		
		
