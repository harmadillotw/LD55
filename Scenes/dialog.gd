extends NinePatchRect

var line_number
var dialog_lines
var dialog
var time_counter
var view_time = 5.0
var initialised = false

signal dialog_complete()
# Called when the node enters the scene tree for the first time.
func _ready():
	line_number = 0
	time_counter = 0.0
	initialised = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if initialised:
		if (Input.is_action_just_released("dialog_accept")):
			initialised = false
			print("F key pressed " + self.name)
			exit()
		time_counter +=delta
		if time_counter > view_time:
			time_counter = 0
			exit()
	
func set_dialog(dialog):
		print("set_dialog " + self.name)
		$spawn_text.text = dialog
		time_counter =0.0
		initialised = true
	
func update_dialog():
	line_number += 1
	if line_number < dialog_lines:
		$spawn_text.text = dialog[line_number]
	else:
		exit()
	

func exit():
	time_counter = 0
	initialised = false
	$spawn_text.text = ""
	dialog_complete.emit()
