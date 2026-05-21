extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $"../Label"
@onready var label_2: Label = $"../Label_2"
@onready var label_3: Label = $"../Label_3"

@onready var key: Sprite2D = $"../Key"

@export var area_pcam: PhantomCamera2D
@onready var npc: CharacterBody2D = $"../NPC"

const JUMP = preload("uid://76frojbsm6pt")

const SPEED = 300.0
const JUMP_VELOCITY = -650.0
var alive = true
var killable = true
var can_move = true

var player_in_area = false
var is_chatting = false
var is_roaming = true

var debounce = false

func _ready():
	label.visible = true
	Dialogic.signal_event.connect(DialogicSignal)
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Escape"):
		get_tree().paused = true
	
	if player_in_area == true:
		if debounce == false:
			debounce = true
			run_dialogue("character1save")
			await get_tree().create_timer(30).timeout
			debounce = false
	
	if alive == true and not is_chatting:
		# Add animation
		if velocity.x > 1 or velocity.x < -1:
			animated_sprite_2d.animation = "run"
		else: 
			animated_sprite_2d.animation = "idle"
	
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		if can_move:
		
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

func run_dialogue(dialogue_string):
	is_chatting = true
	is_roaming = false
	
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg: String):
	if arg == "view_npc":
		print("View")
		
		# camera movement
		
		is_chatting = false
		is_roaming = true
	elif arg == "exit_scene":
		
		key.visible = true
		
		await get_tree().create_timer(5).timeout
		npc.queue_free()
		key.visible = false

func die() -> void:
	alive = false
	animated_sprite_2d.animation = "die"
	animated_sprite_2d.get_node_or_null("Hurt").play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		label.visible = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		label_2.visible = true


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		label_2.visible = false


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		label_3.visible = true


func _on_area_2d_3_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		label_3.visible = false
	

func _on_area_2d_4_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pass


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false


func _on_area_2d_blaaa_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		alive = false
		animated_sprite_2d.animation = "die"
		animated_sprite_2d.get_node_or_null("Hurt").play()
		await get_tree().create_timer(2).timeout
		get_tree().quit()
