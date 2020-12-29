extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


func _on_New_game_pressed():
	var _a = get_tree().change_scene("res://scenes/Main.tscn")
	

func _on_Quit_pressed():
	get_tree().quit()
	


func _on_Credits_pressed():
	get_node("/root/Main menu/Credits").visible = true
	


func _on_Back_pressed():
	get_node("/root/Main menu/Credits").visible = false
