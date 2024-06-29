extends Enemy

@onready var skeloton: AnimatedSprite2D = $"."
@onready var can_attack: Timer = $CanAttack

@onready var hit_box: Area2D = $HitBox

var is_attack: bool = false
var blood_particles_scene := preload("res://elements/Blood_particles/blood_particles.tscn") 

func _ready() -> void:
	can_attack.start()

func _process(delta: float) -> void:
	state_skeloton(delta)
	
func state_skeloton(delta):
	match state:
		State.DIE: die()
		State.HURT: take_damage()
		State.WALK: basic_movement_towards_player(delta)
		State.ATTACK: simple_attack()
		_: basic_movement_towards_player(delta)
	print("state is " + str(state))

func take_damage():
	hp -= damage_on_enemy
	if hp <= 0:
		state = State.DIE
		#die()

func die():
	hit_box.queue_free()
	is_die = true
	skeloton.play("die")
	if skeloton.is_playing():
		await get_tree().create_timer(1).timeout
		is_die = false
		queue_free()
		die_particles()

func simple_attack():
	if is_attack:
		is_attack = false
		skeloton.play("attack")
		print("attack")
		Events.take_damage_player.emit(damage)
		can_attack.start()

func _on_area_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		state = State.ATTACK
		#simple_attack()
		

func _on_area_attack_area_exited(area: Area2D) -> void:
	state = State.WALK
	

func _on_can_attack_timeout() -> void:
	is_attack = true
	print("attack")

func die_particles():
	if Globals.node_creation_parent != null:	
		var blood_particles_intence = Globals.instance_node(blood_particles_scene, Vector2(global_position.x, global_position.y+25), Globals.node_creation_parent)
		blood_particles_intence.rotation = -velocity.angle()
