extends Control

const pre_main_menu = preload("res://Scenes/MainMenuScene1.tscn")

var user_prefs: UserPreferences
# Called when the node enters the scene tree for the first time.
func _ready():
	user_prefs = UserPreferences.load_or_create()
	
	$MarginContainer/VBoxContainer/FXHSlider2.value = user_prefs.fx_volume
	Global.fxVolume = user_prefs.fx_volume
	$MarginContainer/VBoxContainer/MusicHSlider.value = user_prefs.music_volume
	Global.musicVolume = user_prefs.music_volume
	$MarginContainer/VBoxContainer/CheckBox.button_pressed = user_prefs.disable_screen_shake

	Global.disable_screen_shake = user_prefs.disable_screen_shake
	#$MarginContainer/VBoxContainer/FXHSlider2.value = Global.fxVolume
	#$MarginContainer/VBoxContainer/MusicHSlider.value = Global.musicVolume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_packed(pre_main_menu)


func _on_h_slider_value_changed(value):
	Global.musicVolume = value
	
	MasterAudioStreamPlayer.set_volume(value)
	if user_prefs:
		user_prefs.music_volume = value
		user_prefs.save()


func _on_fxh_slider_2_value_changed(value):
	Global.fxVolume = value
	
	if user_prefs:
		user_prefs.fx_volume = value
		user_prefs.save()


func _on_check_box_toggled(toggled_on):
	
	Global.disable_screen_shake =toggled_on
	if user_prefs:
		user_prefs.disable_screen_shake = toggled_on
		user_prefs.save()

