extends CharacterBody2D
class_name Player

const SPEED := 4500

@onready var reload_speed = $Reload_speed
@onready var point_light = $PointLight2D
@onready var player = $"."
@onready var take_damage_timer = $take_damage_timer

var health = 50
var bullet_scene := preload("res://elements/Bullet/bullet.tscn")
var can_shoot = true

func _ready():
	Globals.player = self
	Events.take_damage_player.connect(take_damage)
	Events.health_player.emit(health)
	
func _exit_tree():
	Globals.player = null

func _process(delta):
	if Input.is_action_just_pressed("flash_light"):
		point_light.enabled = !point_light.enabled
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	Events.new_player_pos.emit(global_position)	
	velocity = input_direction * SPEED * delta
	move_and_slide()
	
	if Input.is_action_pressed("shoot") and Globals.node_creation_parent != null and can_shoot:
		Globals.instance_node(bullet_scene, global_position, Globals.node_creation_parent)
		reload_speed.start()
		can_shoot = false


func _on_reload_speed_timeout():
	can_shoot = true

func take_damage(value_damage):
	health -= value_damage
	#await get_tree().create_timer(0.2).timeout 
	player.modulate = "e4576ac1"
	take_damage_timer.start()
	print(health)
	Events.health_player.emit(health)

func _on_take_damage_timer_timeout():
	player.modulate = "ffffff"
