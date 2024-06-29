extends CanvasLayer

@onready var score = $MarginContainer/VBoxContainer/HBoxContainer/Score
@onready var health_bar = $MarginContainer/VBoxContainer/HBoxContainer/health_bar

var health_player: int = 50

func _ready():
	Events.health_player.connect(hp_player)

func _process(delta):
	score.text = str(Globals.points)
	health_bar.text = str(health_player)

func hp_player(hp):
	health_player = hp
