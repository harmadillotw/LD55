extends Node2D
@onready var inv: Inv = preload("res://Items/inventory.tres")
@onready var slots: Array = get_node("Sprite2D").get_children()
var is_open = true


func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
			
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false

