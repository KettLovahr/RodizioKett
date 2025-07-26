extends Sprite2D
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

func _on_see_saw_area_entered(area: Area2D):
	if area is Block:
		if not area.collided:
			area.collided = true
			area.velocity = Vector2(rotation * 500, -200)
			area.rot_speed = rotation
			area.fall_speed = 5
