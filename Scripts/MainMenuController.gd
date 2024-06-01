extends Node2D




var ghost_texture = preload("res://Images/ghost_ph.png")
var tentacle_texture = preload("res://Images/tentacle.png")
var spawn_node = preload("res://Scenes/spawn.tscn")
var eye_monster_node = preload("res://Scenes/eye_monster.tscn")

var spawnInstance 
var spawnLocation

var rng = RandomNumberGenerator.new()
var allow_spawn = true
var spawnLifeTime = 10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	#MasterAudioStreamPlayer.play_music_game()
	#$AudioStreamPlayer.volume_db = Global.fxVolume
	spawnLocation = get_node("SummoningCircle/Spawn_location")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (allow_spawn):
		var spawnType = rng.randi_range(1,20)
		if spawnType > 18:
			summonSpawn(2)
		elif spawnType > 14:
			summonSpawn(3)
		else:
			summonSpawn(1)
	
func summonSpawn(id):
	allow_spawn = false
	spawnInstance = spawn_node.instantiate()
	if id == 1:
		spawnInstance.set_texture(ghost_texture)
	elif id == 3:
		spawnInstance.set_texture(tentacle_texture)
	elif id == 2:
		spawnInstance = eye_monster_node.instantiate()
	spawnInstance.position = spawnLocation.global_position
	spawnLifeTime = rng.randf_range(5.0,10.0)
	spawnInstance.id = id
	add_child(spawnInstance)
	await get_tree().create_timer(spawnLifeTime).timeout
	spawnInstance.queue_free()
	spawnLifeTime = rng.randf_range(3.0,6.0)
	await get_tree().create_timer(spawnLifeTime).timeout
	allow_spawn = true


func _on_play_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/story_start.tscn")


func _on_options_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")


func _on_instructions_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/book_of_instructions.tscn")


func _on_solutions_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/book_of_solutions.tscn")


func _on_credits_play_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/book_of_credits.tscn")

func _on_exit_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().quit()


func _on_solutions_play_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/book_of_solutions.tscn")


func _on_endless_play_button_pressed():
	MasterAudioStreamPlayer.play_fx_click()
	get_tree().change_scene_to_file("res://Scenes/endless_start.tscn")
