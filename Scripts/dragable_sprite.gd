extends Sprite2D

var place_sound = preload("res://Sounds/place.wav")
var place_altar_sound = preload("res://Sounds/place_altar.wav")
var group := "dragable"
var is_dragging = false;
var mouse_offset
var delay = 5
var drop_spots
var dragable_sprites
var inventory_location
var id
var item_location



func _ready():
	add_to_group(group)
	drop_spots = get_tree().get_nodes_in_group("drop_spot_group")
	dragable_sprites =get_tree().get_nodes_in_group("dragable_sprite")
	
func _physics_process(_delta):
	if is_dragging == true and !Global.spawn_active:
		position = get_global_mouse_position()
		#var tween = get_tree().create_tween()
		#tween.tween_property(self,"position", get_global_mouse_position(),delay * delta)
func _input(event):
	if !Global.spawn_active and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#print("d_input_mouse")
		if not event.pressed and is_dragging:
			dragable_sprites =get_tree().get_nodes_in_group("dragable_sprite")
			is_dragging = false
			var found_dropspot = false
			var skip_dropspots = false
			for dragable in dragable_sprites:
				if dragable.has_overlapping_areas() and dragable.get_overlapping_areas().has(self.get_node("Area2D")):
					skip_dropspots = true
			if (!skip_dropspots):	
				for drop_spot in drop_spots:					
					if drop_spot.has_overlapping_areas() and drop_spot.get_overlapping_areas().has(self.get_node("Area2D")):
						var snap_position = drop_spot.global_position
						position = snap_position
						#print("set postion " + str(drop_spot.location))
						item_location = drop_spot.location
						Global.object_at_postion[id] = drop_spot.location
						found_dropspot = true
						MasterAudioStreamPlayer.play_fx(place_sound)
			if !found_dropspot:
				position = inventory_location
				item_location = 0
				Global.object_at_postion[id] = 0
				MasterAudioStreamPlayer.play_fx(place_altar_sound)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !Global.spawn_active and Input.is_action_just_pressed("click"):
		if _is_on_top():
			var ccount = self.get_parent().get_child_count() 
			self.get_parent().move_child(self,ccount)
			is_dragging = true
		
func _is_on_top() -> bool:
	for dragable in get_tree().get_nodes_in_group(group + "hovered"):
		if dragable.get_index() > get_index():
			return false
			
	return true
	
func _on_area_2d_mouse_shape_entered(shape_idx):
	add_to_group(group + "hovered")


func _on_area_2d_mouse_shape_exited(shape_idx):
	remove_from_group(group + "hovered")

