class_name Autoscroller
extends CameraControllerBase

@export var top_left:Vector2 = Vector2(-13.0, 7.0)
@export var bottom_right:Vector2 = Vector2(13.0, -7.0)
@export var autoscroll_speed:Vector3 = Vector3(3.0, 0.0, 3.0)

func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var actual_speed:Vector3 = autoscroll_speed * delta
	
	global_position += actual_speed
	target.position += actual_speed
	
	var tpos = target.global_position
	var cpos = global_position
	
	# Boundary checks
	# Top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - top_left.y)
	if diff_between_top_edges < 0:
		target.global_position.z -= diff_between_top_edges
	# Left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + top_left.x)
	if diff_between_left_edges < 0:
		target.global_position.x -= diff_between_left_edges
	# Right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + bottom_right.x)
	if diff_between_right_edges > 0:
		target.global_position.x -= diff_between_right_edges
	# Bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z - bottom_right.y)
	if diff_between_bottom_edges > 0:
		target.global_position.z -= diff_between_bottom_edges
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# Top
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	# Left
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	# Right
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	# Bottom
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()