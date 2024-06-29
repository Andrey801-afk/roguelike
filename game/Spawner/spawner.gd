extends Node

const WIN_SIZE := 500

@onready var enemy_spawn_timer = $Enemy_spawn_timer

var skeleton_scene = preload("res://elements/Enemies/Skeleton/skeloton.tscn")

var skeleton_pos: Vector2
var spawn_pos := [
	Vector2(1,1),
	Vector2(1,-1),
	Vector2(-1,1),
	Vector2(-1,-1),
]

func _ready():
	enemy_spawn_timer.start()
	Events.new_player_pos.connect(spawn_pos_enemy)

func _on_enemy_spawn_timer_timeout():
	Globals.instance_node(skeleton_scene, skeleton_pos, self)

func spawn_pos_enemy(pos):
	skeleton_pos = spawn_pos.pick_random() * WIN_SIZE + pos


func _on_difficulty_timer_timeout():
	if enemy_spawn_timer.wait_time > 1.25:
		enemy_spawn_timer.wait_time -= 0.1
