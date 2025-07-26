extends Area2D
class_name SeeSaw


var left_rot = -PI/6
var right_rot = PI/6

var target_rotation: float = right_rot

func _process(delta: float) -> void:
	var axis = Input.get_axis("ui_left", "ui_right")

	if axis > 0:
		target_rotation = right_rot
	if axis < 0:
		target_rotation = left_rot
	rotation = lerp(rotation, target_rotation, 0.1)
	
	if Input.is_action_just_pressed("move_shoot"):
		$RayCast2D/Beam.scale = Vector2(1.0, 15)
		$RayCast2D/Beam.modulate = Color.WHITE
		get_tree().create_tween().tween_property($RayCast2D/Beam, "scale", Vector2(0, 15), 0.2)
		get_tree().create_tween().tween_property($RayCast2D/Beam, "modulate", Color(0, 0, 0, 0), 0.2)
		print("fuck")
		var collider = $RayCast2D.get_collider()
		if collider is Block:
			print("there is a block")
			if collider.color == Block.BlockColor.EVIL:
				print("and it is evil")
				collider.health -= 1


func _on_area_entered(area: Area2D) -> void:
	if area is Block:
		if not area.collided:
			area.collided = true
			area.velocity = Vector2(rotation * 500, -200)
			area.rot_speed = rotation
			area.fall_speed = 5
