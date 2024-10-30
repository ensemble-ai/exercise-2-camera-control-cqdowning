class_name LerpTargetFocus
extends CameraControllerBase

@export var lead_speed:float = 0.075
# In seconds
@export var catchup_delay_duration:float = 0.15
@export var catchup_speed:float = 0.1
@export var leash_distance:float = 13.0

const CROSSHAIR_LENGTH:float = 5.0

var _catchup_delay_timer:Timer

func _ready() -> void:
	super()
	position = target.position
	_catchup_delay_timer = Timer.new()
	add_child(_catchup_delay_timer)
	_catchup_delay_timer.one_shot = true


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos:Vector3 = target.global_position
	var cpos:Vector3 = global_position
	tpos.y = 0.0
	cpos.y = 0.0
	
	# The direction the camera should move in
	var camera_lead_direction:Vector3 = (target.velocity).normalized()
	# The direction the camera should move in
	var camera_player_direction:Vector3 = (tpos - cpos).normalized()
	
	var camera_lead_speed:float = (target.velocity).length()
	
	# Fix camera overshooting
	#if cdistance < 0.5 && target.velocity.length() < 0.01:
		#cdistance = 0.0
		#camera_player_direction = Vector3(0.0, 0.0, 0.0)
		#global_position = tpos
	
	if abs(target.velocity) > Vector3(0.0, 0.0, 0.0):
		#global_position += lead_speed * camera_lead_direction * delta
		global_position = lerp(global_position, (0.5 * lead_speed * camera_lead_speed) * leash_distance * camera_lead_direction + target.position, lead_speed)
		_catchup_delay_timer.start(catchup_delay_duration)
	elif _catchup_delay_timer.is_stopped():
		#global_position += catchup_speed * camera_player_direction * delta
		global_position = lerp(global_position, target.position, catchup_speed)
	
	# Recalculate new positions 
	tpos = target.global_position
	cpos = global_position
	tpos.y = 0.0
	cpos.y = 0.0
	# How far apart are the camera and player
	var cdistance:float = abs(tpos - cpos).length()
	# Represents how far over the leash distance the camera has become
	var over = cdistance - leash_distance
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
