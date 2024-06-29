extends Node2D

func _ready():
	Globals.node_creation_parent = self
	
func _exit_tree():
	Globals.node_creation_parent = null



