extends Node2D

const pre_main_menu = preload("res://Scenes/MainMenuScene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_packed(pre_main_menu)



