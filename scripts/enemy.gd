extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy: Area2D = $"."

signal player_died
const SPEED = 100.0
var direction = -1.0
var enemy_alive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemy_alive:
		position.x += direction * SPEED * delta


func _on_timer_timeout() -> void:
	if enemy_alive:
		direction *= -1
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive and body.killable:
		emit_signal("player_died", body)
		
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.alive and enemy_alive:
		body.killable = false
		animated_sprite_2d.animation = "die"
		enemy_alive = false
		
		await get_tree().create_timer(.5).timeout
		body.killable = true
		await get_tree().create_timer(.5).timeout
		enemy.queue_free()
