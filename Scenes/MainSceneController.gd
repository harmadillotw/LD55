extends Node2D

@export var NOISE_SHAKE_SPEED: float = 90.0

@export var inv: Inv
var SHAKE_DECAY_RATE: float = 0.0

var spawn_node = preload("res://Scenes/spawn.tscn")
var eye_monster_node = preload("res://Scenes/eye_monster.tscn")
var dragable_node = preload("res://Scenes/dragable_sprite.tscn")
var ghost_texture = preload("res://Images/ghost_ph.png")
var candle_texture = preload("res://Images/candle.png")
var dagger_texture = preload("res://Images/dagger.png")
var chalice_texture = preload("res://Items/chalice.png")
var crystal_texture = preload("res://Items/crystal.png")
var salt_texture = preload("res://Items/salt.png")
var herbs_texture = preload("res://Items/herbs.png")
var tentacle_texture = preload("res://Images/tentacle.png")
var spawnLocation 
var summonProgress
var text_delay = 1.0
#var spawnActive = false
var spawnButtonPressed = false
var spawnInstance 
var inv_slot1_location
var inv_slot2_location
var inv_slot3_location
var inv_slot4_location
var inv_slot5_location
var inv_slot6_location


#Screen Shake
var camera
var noise
var noise_i: float = 0.0
var shake_strength: float = 30.0
#var spawnButton
# Called when the node enters the scene tree for the first time.
func _ready():
	inv_slot1_location = get_node("inv_ui_2d/ui_slot_1")
	inv_slot2_location = get_node("inv_ui_2d/ui_slot_2")
	inv_slot3_location = get_node("inv_ui_2d/ui_slot_3")
	inv_slot4_location = get_node("inv_ui_2d/ui_slot_4")
	inv_slot5_location = get_node("inv_ui_2d/ui_slot_5")
	inv_slot6_location = get_node("inv_ui_2d/ui_slot_6")
	spawnLocation = get_node("SummoningCircle/Spawn_location")
	summonProgress = get_node("SummonProgress")
	#spawnButton = get_node("SpawnButton")
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.DOMAIN_WARP_SIMPLEX
	noise.frequency = 0.3
	camera = get_node("Camera2D")
	spawn_dragable(candle_texture, inv_slot1_location.global_position, 1)
	spawn_dragable(dagger_texture, inv_slot2_location.global_position, 2)
	spawn_dragable(chalice_texture, inv_slot3_location.global_position, 3)
	spawn_dragable(crystal_texture, inv_slot4_location.global_position, 4)
	spawn_dragable(salt_texture, inv_slot5_location.global_position, 5)
	spawn_dragable(herbs_texture, inv_slot6_location.global_position, 6)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (spawnButtonPressed):
		if (!Global.spawn_active):
			shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
			camera.offset = get_noise_offset(delta)
			summonProgress.value += 1

func _on_summon_progress_value_changed(value):
	if value == 100:
		if validate_spawn(Global.ghost_spawn_validation):
			spawn_summon(1)
		elif validate_spawn(Global.eye_spawn_validation):
			spawn_summon(2)	
		elif validate_spawn(Global.tentacle_spawn_validation):
			spawn_summon(3)	
		elif validate_spawn(Global.next_spawn_validation):
			spawn_summon(4)	
		else:
			return
		await play_dialog()
		if spawnInstance != null:
			spawnInstance.queue_free()
			Global.spawn_active = false
		summonProgress.value = 0
		
		
func validate_spawn( spawn_validation) -> bool:
	var valid = true
	print(str(Global.object_at_postion))
	for n in range(1,6):
		#var t1 = Global.object_at_postion[n]
		#var t2 = Global.ghost_spawn_validation[n-1]
		print(str(Global.object_at_postion[n]))
		if  Global.object_at_postion[n] != spawn_validation[n-1]:
			valid = false
	return valid
func spawn_dragable(dragTexture, inv_loc, id):
	var dragInstance = dragable_node.instantiate()
	dragInstance.set_texture(dragTexture)
	dragInstance.position = inv_loc
	dragInstance.inventory_location = inv_loc;
	dragInstance.id = id
	dragInstance.item_location = 0
	add_child(dragInstance)
		
func spawn_summon(id):
	if (!Global.spawn_active):
		Global.spawn_active = true
		if (id == 2):
			spawnInstance = eye_monster_node.instantiate()
		elif (id == 1):
			spawnInstance = spawn_node.instantiate()
			spawnInstance.set_texture(ghost_texture)
		elif (id == 3):
			spawnInstance = spawn_node.instantiate()
			spawnInstance.set_texture(tentacle_texture)
		elif (id == 4):
			spawnInstance = spawn_node.instantiate()
			spawnInstance.set_texture(ghost_texture)
		spawnInstance.position = spawnLocation.global_position
		spawnInstance.id = id
		Global.ghost1_summon_count += 1
		add_child(spawnInstance)



func _on_spawn_button_button_down():
	if (Global.spawn_active):
		spawnButtonPressed = false
	else:
		spawnButtonPressed = true


func _on_spawn_button_button_up():
	spawnButtonPressed = false
	summonProgress.value = 0
	
func get_noise_offset(delta: float) -> Vector2:
	noise_i += delta * NOISE_SHAKE_SPEED
	return Vector2(
		noise.get_noise_2d(1,noise_i) * shake_strength,
		noise.get_noise_2d(100,noise_i) * shake_strength
	)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			if spawnInstance != null and spawnInstance.get_rect().has_point(to_local(event.position)):
				spawnInstance.queue_free()
				Global.spawn_active = false
				
func play_dialog():
	var spawn_dialog
	var summoner_dialog
	var dialog_length = 0
	
	if spawnInstance.id == 1:
		if !Global.active_pages.has(2):
			Global.active_pages.append(2)
			Global.max_page += 1
		if Global.ghost1_summon_count == 10:
			spawn_dialog = Global.ghost_dialog_ghost_3
			summoner_dialog = Global.ghost_dialog_reply_3
			dialog_length = 2
		elif Global.ghost1_summon_count == 1:
			spawn_dialog = Global.ghost_dialog_ghost_1
			summoner_dialog = Global.ghost_dialog_reply_1
			dialog_length = 4
		else:
			spawn_dialog = Global.ghost_dialog_ghost_2
			summoner_dialog = Global.ghost_dialog_reply_2
			dialog_length = 1
	elif spawnInstance.id == 2:
		if !Global.active_pages.has(3):
			Global.active_pages.append(3)
			Global.max_page += 1
		spawn_dialog = Global.eye_dialog_eye_1
		summoner_dialog = Global.eye_dialog_reply_1
		dialog_length = 5
	elif spawnInstance.id == 3:
		if !Global.active_pages.has(4):
			Global.active_pages.append(4)
			Global.max_page += 1
		spawn_dialog = Global.tentacle_dialog_tentacle_1
		summoner_dialog = Global.tentacle_dialog_reply_1
		dialog_length = 1
	elif spawnInstance.id == 4:
		if !Global.active_pages.has(4):
			Global.active_pages.append(4)
			Global.max_page += 1
		spawn_dialog = Global.tentacle_dialog_tentacle_1
		summoner_dialog = Global.tentacle_dialog_reply_1
		dialog_length = 1
	for n in range(0,dialog_length):	
		$spawn_text.text = spawn_dialog[n];
		$summoner_text.text = ""
		await get_tree().create_timer(text_delay).timeout
		$summoner_text.text = summoner_dialog[n]
		$spawn_text.text = ""
		await get_tree().create_timer(text_delay).timeout
	$spawn_text.text = ""
	$summoner_text.text = ""
	


func _on_button_pressed():
	$book_of_shadows.visible = true
