extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const JUMP = preload("uid://76frojbsm6pt")

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
var alive = true

func _physics_process(delta: float) -> void:
	
	if alive == true:
		# Add animation
		if velocity.x > 1 or velocity.x < -1:
			animated_sprite_2d.animation = "run"
		else: 
			animated_sprite_2d.animation = "idle"
	
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.get_node("Jump").play()

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
	
		if direction == 1.0:
			animated_sprite_2d.flip_h = false
		elif direction == -1.0:
			animated_sprite_2d.flip_h = true
	
func die() -> void:
	alive = false
	animated_sprite_2d.animation = "die"
	animated_sprite_2d.get_node_or_null("Hurt").play()


func _on_tip_area_1_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
