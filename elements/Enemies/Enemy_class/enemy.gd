extends AnimatedSprite2D
class_name Enemy

enum State {WALK, ATTACK, HURT, DIE}

@export var hp: int = 3
@export var speed := 65
@export var damage := 3
@onready var enemy: Enemy = $"."

var state := State.WALK
var is_die: bool = false
var damage_on_enemy: int = Bullet.new().damage
var velocity: Vector2
var skeleton_points := 10
var is_stun := false

func basic_movement_towards_player(delta):
	if Globals.player != null and is_stun == false:
		if abs(global_position.x - Globals.player.global_position.x) > 15:
			velocity = global_position.direction_to(Globals.player.global_position)
		elif abs(global_position.y - Globals.player.global_position.y) > 15:
			velocity.y = global_position.direction_to(Globals.player.global_position).y
		else:	
			velocity = Vector2.ZERO
	elif is_stun:
		velocity = lerp(velocity, Vector2.ZERO, 0.3)
	global_position += velocity * speed * delta
	if global_position.x - Globals.player.global_position.x > 0:
		scale = Vector2(-1,1)
	else:
		scale = Vector2(1,1)
	
func take_damage():
	hp -= damage_on_enemy
	speed *= -10
	if hp <= 0:
		state = State.DIE
		#die()
		
func die():
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_damager"):
		state = State.HURT
		#take_damage()

