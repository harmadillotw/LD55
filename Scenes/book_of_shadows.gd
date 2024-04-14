extends Control

var page =1;
# Called when the node enters the scene tree for the first time.
func _ready():
	load_page()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	self.visible = false


func _on_next_button_pressed():
	page += 1
	if page > Global.max_page:
		page = Global.max_page
	load_page()

func _on_previous_button_pressed():
	page -= 1
	if page < 1 :
		page = 1
	load_page()
	
func load_page():
	$PageLabel.text = str(page) + "/" + str(Global.max_page)
	var a_size = Global.active_pages.size()
	if a_size >= page:
		match Global.active_pages[page-1]:
			1:
				populate_page( Global.bos_page1_left, Global.bos_page1_right , Global.bos_page1_image_left , Global.bos_page1_image_right)
			2:
				populate_page( Global.bos_page2_left, Global.bos_page2_right , Global.bos_page2_image_left , Global.bos_page2_image_right)
			3:
				populate_page( Global.bos_page3_left, Global.bos_page3_right , Global.bos_page3_image_left , Global.bos_page3_image_right)
			4:
				populate_page( Global.bos_page4_left, Global.bos_page4_right , Global.bos_page4_image_left , Global.bos_page4_image_right)

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
