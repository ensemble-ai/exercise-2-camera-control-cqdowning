class_name LerpTargetFocus
extends CameraControllerBase
## Stage 4 - Target focus with lerp
##
## This camera implements a look-ahead camera using lerp
## The camera will move ahead of the vessel in the direction of movement

# The length of each part of the crosshair
const CROSSHAIR_LENGTH:float = 2.5

# Lerp rate for camera moving ahead
@export var lead_speed:float = 3
# Time in seconds of delay before camera returns to vessel
@export var catchup_delay_duration:float = 0.15
# Lerp rate for camera returning to vessel
@export var catchup_speed:float = 5
# The maximum allowed distance the camera can be from the vessel
@export var leash_distance:float = 13.0

# Timer for the catchup delay
var _catchup_delay_timer:Timer


func _ready() -> void:
	super()
	position = target.position
	# Initialize the timer
	_catchup_delay_timer = Timer.new()
	add_child(_catchup_delay_timer)
	_catchup_delay_timer.one_shot = true


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	# Calculate the positions of vessel and camera
	var tpos:Vector3 = target.global_position
	var cpos:Vector3 = global_position
	# Set the y-components to zero so the height difference between vessel and camera does not affect the distance and direction calculations
	tpos.y = 0.0
	cpos.y = 0.0
	
	# The direction the camera should move ahead in
	var camera_lead_direction:Vector3 = (target.velocity).normalized()
	# The direction the camera should move back toward the vessel in
	var camera_player_direction:Vector3 = (tpos - cpos).normalized()
	# Use the vessel speed to help the camera reach max leash distance
	var camera_lead_speed_multiplier:float = (target.velocity).length() * 0.06
	# When the vessel is moving, lerp ahead of it
	if abs(target.velocity) > Vector3(0.0, 0.0, 0.0):
		global_position = lerp(global_position, (camera_lead_speed_multiplier * leash_distance * camera_lead_direction) + target.position, 1 - pow(2, -lead_speed * delta)) # Makes lerp framerate independent
		# Repeatedly begin the timer while vessel is moving
		_catchup_delay_timer.start(catchup_delay_duration)
	# When the vessel is not moving, the timer can tick down and then the camera is allowed to return to the vessel
	elif _catchup_delay_timer.is_stopped():
		global_position = lerp(global_position, target.position, 1 - pow(2, -catchup_speed * delta))
	
	# Recalculate new positions for after the lerp
	tpos = target.global_position
	cpos = global_position
	# Set the y-components to zero so the height difference between vessel and camera does not affect the distance and direction calculations
	tpos.y = 0.0
	cpos.y = 0.0
	# How far apart are the camera and player
	var cdistance:float = abs(tpos - cpos).length()
	# Represents how far over the leash distance the camera has become
	var over = cdistance - leash_distance
	# If the camera goes over the leash distance, pull it back in towards the vessel
	if over > 0.01:
		global_position += over * camera_player_direction
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# Top
	immediate_mesh.surface_add_vertex(Vector3(0, 0, CROSSHAIR_LENGTH))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	# Left
	immediate_mesh.surface_add_vertex(Vector3(-CROSSHAIR_LENGTH, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	# Right
	immediate_mesh.surface_add_vertex(Vector3(CROSSHAIR_LENGTH, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	# Bottom
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -CROSSHAIR_LENGTH))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
