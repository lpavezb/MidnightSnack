extends Node

onready var new_game_button = $"MarginContainer/HSplitContainer/Menu izquierdo/Botones/New game"
onready var credits_button = $"MarginContainer/HSplitContainer/Menu izquierdo/Botones/Credits"
onready var quit_button = $"MarginContainer/HSplitContainer/Menu izquierdo/Botones/Quit"


# Called when the node enters the scene tree for the first time.
func _ready():
	quit_button.connect("button_down", self, "quit")
	new_game_button.connect("button_down", self, "new_game")
	pass # Replace with function body.


func quit():
	get_tree().quit()

func new_game():
	get_tree().change_scene("res://scenes/Main.tscn")
