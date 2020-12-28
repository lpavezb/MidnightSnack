extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


func _on_New_game_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	

func _on_Quit_pressed():
	get_tree().quit()
	
