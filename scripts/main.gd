extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()
	
#@onready var coins: Node2D = $Coins

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_level() -> void:
	
	# var exit = $".".get_node_or_null("Enemies") #WATCH THE VIDEO ON ADDING MORE LEVELS AND CONTINUE FROM HERE
	
	# Connect enemies
	var enemies = $".".get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)
			

# Signal Handlers

func _on_player_died(body: CharacterBody2D):
	print(body.name + " died")
	body.die()
	
