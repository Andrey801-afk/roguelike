extends Sprite2D
class_name Bullet

var damage := 1
var speed = 250
var velocity = Vector2(1,0)
var look_once = true

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once = false
	global_position += velocity.rotated(rotation) * speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		Events.take_damage_enemy.emit(damage)
		queue_free()
