class_name SpeedupPushBox
extends CameraControllerBase

@export var push_ratio:float = 0.7
@export var pushbox_top_left:Vector2 = Vector2(-13.0, 7.0)
@export var pushbox_bottom_right:Vector2 = Vector2(13.0, -7.0)
@export var speedup_zone_top_left:Vector2 = Vector2(-10.0, 4.0)
@export var speedup_zone_bottom_right:Vector2 = Vector2(10.0, -4.0)


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	# Boundary checks
	# Top
	var pushbox_diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left.y)
	var speedup_diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - speedup_zone_top_left.y)
	if pushbox_diff_between_top_edges < 0:
		global_position.z += pushbox_diff_between_top_edges
	elif speedup_diff_between_top_edges < 0:
		global_position.z += target.velocity.z * push_ratio * delta
	# Left
	var pushbox_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_top_left.x)
	var speedup_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + speedup_zone_top_left.x)
	if pushbox_diff_between_left_edges < 0:
		global_position.x += pushbox_diff_between_left_edges
	elif speedup_diff_between_left_edges < 0:
		global_position.x += target.velocity.x * push_ratio * delta
	# Right
	var pushbox_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.x)
	var speedup_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_bottom_right.x)
	if pushbox_diff_between_right_edges > 0:
		global_position.x += pushbox_diff_between_right_edges
	elif speedup_diff_between_right_edges > 0:
		global_position.x += target.velocity.x * push_ratio * delta
	# Bottom
	var pushbox_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z - pushbox_bottom_right.y)
	var speedup_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z - speedup_zone_bottom_right.y)
	if pushbox_diff_between_bottom_edges > 0:
		global_position.z += pushbox_diff_between_bottom_edges
	elif speedup_diff_between_bottom_edges > 0:
		global_position.z += target.velocity.z * push_ratio	* delta
		
	super(delta)


func draw_logic() -> void:
	var speedup_mesh_instance := MeshInstance3D.new()
	var speedup_immediate_mesh := ImmediateMesh.new()
	var speedup_material := ORMMaterial3D.new()
	
	speedup_mesh_instance.mesh = speedup_immediate_mesh
	speedup_mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	speedup_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, speedup_material)
	# Top
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	# Left
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	# Right
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	# Bottom
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	speedup_immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	speedup_immediate_mesh.surface_end()

	speedup_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	speedup_material.albedo_color = Color.YELLOW
	
	add_child(speedup_mesh_instance)
	speedup_mesh_instance.global_transform = Transform3D.IDENTITY
	speedup_mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	var pushbox_mesh_instance := MeshInstance3D.new()
	var pushbox_immediate_mesh := ImmediateMesh.new()
	var pushbox_material := ORMMaterial3D.new()
	
	pushbox_mesh_instance.mesh = pushbox_immediate_mesh
	pushbox_mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	pushbox_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, pushbox_material)
	# Top
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	# Left
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	# Right
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	# Bottom
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	pushbox_immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	pushbox_immediate_mesh.surface_end()

	pushbox_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	pushbox_material.albedo_color = Color.BLACK
	
	add_child(pushbox_mesh_instance)
	pushbox_mesh_instance.global_transform = Transform3D.IDENTITY
	pushbox_mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	pushbox_mesh_instance.queue_free()
	speedup_mesh_instance.queue_free()
