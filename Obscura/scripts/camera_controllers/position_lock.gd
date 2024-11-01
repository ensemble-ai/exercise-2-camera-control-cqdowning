class_name PositionLock
extends CameraControllerBase
## Stage 1 - Position lock Camera
##
## This camera will always be centered on the Vessel
## Draw logic creates a 5 by 5 unit cross in the center of the screen

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
	
	# Get the vessel position
	var tpos = target.global_position
	
	# Move camera to vessel position
	global_position.x = tpos.x
	global_position.z = tpos.z
		
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
