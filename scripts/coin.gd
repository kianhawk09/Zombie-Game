extends CollisionShape2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

const COINS_NEEDED = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var coins = 0.0
func _on_coin_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animated_sprite_2d.get_node_or_null("Coin").play()
		coins += 1
		print(body.name + " collected a coin. Count: " + str(coins))
		if coins >= COINS_NEEDED:
			print(body.name + " won!")
