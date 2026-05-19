extends Node2D

var current_level_root : Node = null
var level : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	current_level_root = get_node("LevelRoot")
	_load_level(level)

func _load_level(level_number : int) -> void:
	if current_level_root:
		current_level_root.queue_free()
	
	var level_path = "res://scenes/level%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "LevelRoot"
	_setup_level(current_level_root)
	
func _setup_level(level_root : Node) -> void:
	
	var exit = level_root.get_node_or_null("Area2D_4")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	
	# Connect enemies
	var enemies = level_root.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
			

# Signal Handlers

func _on_exit_body_entered(body : Node2D) -> void:
	if body.name == "Player":
		level += 1
		body.can_move = false
		call_deferred("_load_level", level)

func _on_player_died(body: CharacterBody2D):
	print(body.name + " died")
	body.die()
	
