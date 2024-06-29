extends Node

signal new_player_pos(pos: Vector2)
signal camera_screen_snake(intencity, time)
signal take_damage_player(int)
signal health_player(int)
signal take_damage_enemy(damage: int)
#signal die_enemy()
signal Transitioned_state() # происходит при перехое в новое состояние 
