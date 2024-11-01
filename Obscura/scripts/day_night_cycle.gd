class_name DayNightCycle
extends DirectionalLight3D
## Day-Night Cycle Controller
##
## This script controls the day-night cycle of the world
## This changes the angle, brightness, and color of the sun/moon according the current time

# The speed of the entire day-night cycle
@export var speed:float = 7.0
# The color of the sunrise
@export var sunrise_color:Color
# The color of the daytime
@export var day_color:Color
# the color of the sunset
@export var sunset_color:Color
# The color of the nighttime
@export var night_color:Color
# The length of the day
@export var day_length:float = 160.0
# The length of the night
@export var night_length:float = 80.0

# The current time
# This is zero at the start of the day AND at the start of the night
var _current_time:float = 0.0
# Whether it is daytime or not
var _is_daytime:bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make sure y rotation is constant
	global_rotation.y = deg_to_rad(90)
	# Have time move
	_current_time += speed * delta
	# Handle switching from daytime to nighttime
	if _is_daytime && _current_time > day_length:
		_current_time = 0
		_is_daytime = false
	# Handle switching from nighttime to daytime
	if !_is_daytime && _current_time > night_length:
		_current_time = 0
		_is_daytime = true
	
	# Handle the angle of the light
	_orbit()
	# Handle the brightness of the light
	_energy()
	# Handle the color of the light
	_color()


# Handles the angle of the global light according to current time
func _orbit():
	if _is_daytime:
		global_rotation.x = deg_to_rad(lerp(180.0, 360.0, _current_time / day_length))
	else:
		global_rotation.x = deg_to_rad(lerp(180.0, 360.0, _current_time / night_length))


# Handles the brightness of the global light according to current time
func _energy():
	if _is_daytime:
		if _current_time < day_length * 0.40:
			light_energy = lerp(0.1, 1.0, _current_time / (day_length * 0.40))
		elif _current_time > day_length * 0.60:
			light_energy = lerp(1.0, 0.1, (_current_time - (day_length * 0.60)) / (day_length * 0.40))
	else:
		light_energy = 0.1


# Handles the color of the global light according to current time
func _color():
	if _is_daytime:
		if _current_time < day_length * 0.10:
			light_color = lerp(night_color, sunrise_color, _current_time / (day_length * 0.10))
		elif _current_time < day_length * 0.30:
			light_color = lerp(sunrise_color, day_color, (_current_time - (day_length * 0.10)) / (day_length * 0.20))
		elif _current_time > day_length * 0.70:
			light_color = lerp(day_color, sunset_color, (_current_time - (day_length * 0.70)) / (day_length * 0.20))
		elif _current_time > day_length * 0.90:
			light_color = lerp(sunset_color, night_color, (_current_time - (day_length * 0.90)) / (day_length * 0.10))
	else:
		light_color = night_color
