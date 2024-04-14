extends Control

const pre_main_menu = preload("res://Scenes/MainMenuScene1.tscn")

var page =1
var max_pages = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	load_page()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	get_tree().change_scene_to_packed(pre_main_menu)


func _on_next_button_pressed():
	$AudioStreamPlayer.play()
	page += 1
	if page > max_pages:
		page = max_pages
	load_page()

func _on_previous_button_pressed():
	$AudioStreamPlayer.play()
	page -= 1
	if page < 1 :
		page = 1
	load_page()
	
func load_page():
	$PageLabel.text = str(page) + "/" + str(max_pages)
	match page:
		1:
			populate_page( "", "" , "res://Images/ghost_ph.png" , "res://Images/solutions/solution1.png")
		2:
			populate_page( "", "" , "res://Images/solutions/eyemonster.png" , "res://Images/solutions/solution2.png")
		3:
			populate_page( "", "" , "res://Images/tentacle.png" , "res://Images/solutions/solution3.png")	
		4:
			populate_page( "","" , "res://Images/mantis.png" , "res://Images/solutions/solution4.png")
		5:
			populate_page( "","" , "res://Images/Demon.png" , "res://Images/solutions/solution5.png")

func populate_page(t_left, t_right, i_left, i_right):
	$TextLabelLeft.text = t_left
	$TextLabelRight.text = t_right
	$Sprite2DLeft.set_texture(null)
	$Sprite2DRight.set_texture(null)
	if i_left != null and i_left.length() > 0:
		var i_sprite = load(i_left)
		$Sprite2DLeft.set_texture(i_sprite)
	if i_right != null and i_right.length() > 0:
		var r_sprite = load(i_right)
		$Sprite2DRight.set_texture(r_sprite)
	
func _on_visibility_changed():
	if self.visible == true:
		load_page()	
