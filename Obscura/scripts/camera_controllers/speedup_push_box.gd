class_name SpeedupPushBox
extends CameraControllerBase
## Stage 5 - 4-way speedup push zone
##
## This camera implements a 4-directional speedup push zone
## When the vessel enters the speedup zone, the camera moves at a fraction of the vessel's speed
## When the vessel touches the outer pushbox, the camera moves at the vessel's speed

# The ratio that the camera should move toward the target when it is not at the edge of the outer pushbox
@export var push_ratio:float = 0.5
# The top left corner of the push zone border box
@export var pushbox_top_left:Vector2 = Vector2(-24.0, 12.0)
# The bottom right corner of the push zone border box
@export var pushbox_bottom_right:Vector2 = Vector2(24.0, -12.0)
# The top left corner of the inner border of the speedup zone
@export var speedup_zone_top_left:Vector2 = Vector2(-16.0, 8.0)
# The bottom right cordner of the inner boarder of the speedup zone
@export var speedup_zone_bottom_right:Vector2 = Vector2(16.0, -8.0)


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()

	# Calculate the positions of vessel and camera
	var tpos = target.global_position
	var cpos = global_position
	
	# Boundary checks
	# These check for when the vessel is inside the speedup zone or when the vessel is against the pushbox
	# When the vessel is in the speedup zone, the camera is allowed to move outward at a fraction of the vessel's speed
	# When the vessel is against the pushbox, the camera moves at the same speed and direction as the vessel
	# Top
	var pushbox_diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left.y)
	var speedup_diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - speedup_zone_top_left.y)
	if pushbox_diff_between_top_edges < 0:
		global_position.z += pushbox_diff_between_top_edges
	elif speedup_diff_between_top_edges < 0:
		global_position.z += clamp(target.velocity.z * push_ratio * delta, -INF, 0.0)
	# Left
	var pushbox_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_top_left.x)
	var speedup_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + speedup_zone_top_left.x)
	if pushbox_diff_between_left_edges < 0:
		global_position.x += pushbox_diff_between_left_edges
	elif speedup_diff_between_left_edges < 0:
		global_position.x += clamp(target.velocity.x * push_ratio * delta, -INF, 0.0)
	# Right
	var pushbox_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_bottom_right.x)
	var speedup_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_zone_bottom_right.x)
	if pushbox_diff_between_right_edges > 0:
		global_position.x += pushbox_diff_between_right_edges
	elif speedup_diff_between_right_edges > 0:
		global_position.x += clamp(target.velocity.x * push_ratio * delta, 0.0, INF)
	# Bottom
	var pushbox_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z - pushbox_bottom_right.y)
	var speedup_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z - speedup_zone_bottom_right.y)
	if pushbox_diff_between_bottom_edges > 0:
		global_position.z += pushbox_diff_between_bottom_edges
	elif speedup_diff_between_bottom_edges > 0:
		global_position.z += clamp(target.velocity.z * push_ratio	* delta, 0.0, INF)
		
	super(delta)


func draw_logic() -> void:
	# Draw speedup zone
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
	
	# Draw pushbox
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
