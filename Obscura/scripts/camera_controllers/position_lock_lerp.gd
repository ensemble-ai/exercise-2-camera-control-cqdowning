class_name PositionLockLerp
extends CameraControllerBase
## Stage 3 - Position lock with lerp smoothing
##
## This camera implements a position lock camera using lerp
## The camera will lag behind the vessel and smoothly catchup

# The lerp rate for following a moving vessel
@export var follow_speed:float = 4
# The lerp rate for catching up to a stopped vessel
@export var catchup_speed:float = 6
# The maximum allowed distance the camera can be from the vessel
@export var leash_distance:float = 13.0

# The length of each part of the crosshair
const CROSSHAIR_LENGTH:float = 2.5

func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	# When the vessel is moving, lerp towards it
	if abs(target.velocity) > Vector3(0.0, 0.0, 0.0):
		global_position = lerp(global_position, target.position, 1 - pow(2, -follow_speed * delta)) # Makes lerp framerate independent
	else:
		global_position = lerp(global_position, target.position, 1 - pow(2, -catchup_speed * delta)) # Makes lerp framerate independent
	
	# Recalculate new positions of the vessel and camera
	var tpos:Vector3 = target.global_position
	var cpos:Vector3 = global_position
	# Set the y-components to zero so the height difference between vessel and camera does not affect the distance and direction calculations
	tpos.y = 0.0
	cpos.y = 0.0
	# How far apart are the camera and player
	var cdistance:float = (tpos - cpos).length()
	# The direction the camera should move in
	var cdirection:Vector3 = (tpos - cpos).normalized()
	# Represents how far over the leash distance the camera has become
	var over = cdistance - leash_distance
	# If the camera goes over the leash distance, pull it back in towards the vessel
	if over > 0.01:
		global_position += over * cdirection
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
