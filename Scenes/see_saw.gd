extends Area2D
class_name SeeSaw


var left_rot = -PI/6
var right_rot = PI/6

var target_rotation: float = right_rot

var switch_speed: float = 0.1


var can_shoot: bool = true:
	set(v):
		can_shoot = v
		$CanShootIndicator.modulate = Color.WHITE if can_shoot else Color.DARK_GRAY

func _process(delta: float) -> void:
	var axis = Input.get_axis("move_left", "move_right")

	if axis > 0:
		target_rotation = right_rot
	if axis < 0:
		target_rotation = left_rot
	rotation = lerp(rotation, target_rotation, switch_speed)
	
	if Input.is_action_just_pressed("move_shoot") and can_shoot:
		$RayCast2D/Beam.scale = Vector2(1.0, 15)
		$RayCast2D/Beam.modulate = Color.WHITE
		get_tree().create_tween().tween_property($RayCast2D/Beam, "scale", Vector2(0, 15), 0.2)
		get_tree().create_tween().tween_property($RayCast2D/Beam, "modulate", Color(0, 0, 0, 0), 0.2)
		var collider = $RayCast2D.get_collider()
		self.can_shoot = false
		$CanShootTimer.start(%Spawner.spawn_delay * 1.2)
		if collider is Block:
			if collider.color == Block.BlockColor.EVIL:
				collider.health -= 1


func _on_area_entered(area: Area2D) -> void:
	if area is Block:
		if not area.collided:
			area.collided = true
			area.velocity = Vector2(rotation * 500, -200)
			area.rot_speed = rotation
			area.fall_speed = 5


func _on_can_shoot_timer_timeout() -> void:
	self.can_shoot = true
