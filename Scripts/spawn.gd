extends Sprite2D

var startPos
var rng = RandomNumberGenerator.new()
var delay = 100
@onready var mainScene = get_parent()
@onready var _animated_sprite1 = $AnimatedSprite2D1
@onready var _animated_sprite2 = $AnimatedSprite2D2
@onready var _animated_sprite3 = $AnimatedSprite2D3
@onready var _animated_sprite4 = $AnimatedSprite2D4
@onready var _animated_sprite5 = $AnimatedSprite2D5
@onready var _animated_sprite6 = $AnimatedSprite2D6
@onready var _animated_sprite7 = $AnimatedSprite2D7
@onready var _animated_sprite8 = $AnimatedSprite2D8
@onready var _animated_sprite9 = $AnimatedSprite2D9
@onready var _animated_sprite10 = $AnimatedSprite2D10
@onready var _animated_sprite11 = $AnimatedSprite2D11
var id : int
# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = self.position
	if id == 2:
		_animated_sprite1.play("default")
		var rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite2.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite3.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite4.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite5.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite6.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite7.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite8.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite9.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite10.play("default")
		rand_num = rng.randf_range(0.1,0.8)
		await get_tree().create_timer(rand_num).timeout
		_animated_sprite11.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if id == 1 or id == 3 or id == 4 or id == 5:
		var tween = get_tree().create_tween()
		var randX = rng.randf_range(-50.0, 50.0)
		var randY = rng.randf_range(-50.0, 50.0)
		var newPos = Vector2(startPos.x - randX, startPos.y -randY)  
		tween.tween_property(self,"position", newPos,delay * delta)
	
func _input(event):
	if event is InputEventMouseButton:
		#print("Button")
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			#print("Right Button")
			if get_rect().has_point(to_local(event.position)):
				#print("on spawn")
				Global.spawn_active = false
				queue_free()
	
