class_name DayNightCycle
extends DirectionalLight3D

@export var speed:float = 10.0
@export var sunrise_color:Color
@export var day_color:Color
@export var sunset_color:Color
@export var night_color:Color

const DAY_LENGTH:float = 140.0
const NIGHT_LENGTH:float = 100.0

var _current_time:float = 0.0
var _is_daytime:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation.y = deg_to_rad(90)
	_current_time += speed * delta
	if _is_daytime && _current_time > DAY_LENGTH:
		_current_time = 0
		_is_daytime = false
	if !_is_daytime && _current_time > NIGHT_LENGTH:
		_current_time = 0
		_is_daytime = true
	_orbit()
	_energy()
	_color()

func _orbit():
	if _is_daytime:
		global_rotation.x = deg_to_rad(lerp(180.0, 360.0, _current_time / DAY_LENGTH))
	else:
		global_rotation.x = deg_to_rad(lerp(180.0, 360.0, _current_time / NIGHT_LENGTH))

func _energy():
	if _is_daytime:
		if _current_time < DAY_LENGTH * 0.40:
			light_energy = lerp(0.1, 1.0, _current_time / (DAY_LENGTH * 0.40))
		elif _current_time > DAY_LENGTH * 0.60:
			light_energy = lerp(1.0, 0.1, (_current_time - (DAY_LENGTH * 0.60)) / (DAY_LENGTH * 0.40))
	else:
		light_energy = 0.1

func _color():
	if _is_daytime:
		if _current_time < DAY_LENGTH * 0.10:
			light_color = lerp(night_color, sunrise_color, _current_time / (DAY_LENGTH * 0.10))
		elif _current_time < DAY_LENGTH * 0.30:
			light_color = lerp(sunrise_color, day_color, (_current_time - (DAY_LENGTH * 0.10)) / (DAY_LENGTH * 0.20))
		elif _current_time > DAY_LENGTH * 0.70:
			light_color = lerp(day_color, sunset_color, (_current_time - (DAY_LENGTH * 0.70)) / (DAY_LENGTH * 0.20))
		elif _current_time > DAY_LENGTH * 0.90:
			light_color = lerp(sunset_color, night_color, (_current_time - (NIGHT_LENGTH * 0.90)) / (NIGHT_LENGTH * 0.10))
	else:
		light_color = night_color
