extends Area2D
class_name SeeSaw


var left_rot = -PI/6
var right_rot = PI/6

var target_rotation: float = right_rot

var switch_speed: float = 0.1

@onready var robot: AnimatedSprite2D = $CanShootIndicator/Robot
@onready var see_saw_sprites: AnimatedSprite2D = $SeeSawSprites

var can_shoot: bool = true:
	set(v):
		can_shoot = v
		$CanShootIndicator.modulate = Color.WHITE if can_shoot else Color.DARK_GRAY

func _ready() -> void:
	robot.play("default")

func _process(delta: float) -> void:
	var axis = Input.get_axis("move_left", "move_right")

	if axis > 0:
		target_rotation = right_rot
		see_saw_sprites.play("right")
	if axis < 0:
		target_rotation = left_rot
		see_saw_sprites.play("left")
	rotation = lerp(rotation, target_rotation, switch_speed)
	
	if Input.is_action_just_pressed("move_shoot") and can_shoot:
		robot.play("shoot")


func _on_area_entered(area: Area2D) -> void:
	if area is Block:
		if not area.collided:
			area.collided = true
			area.velocity = Vector2(rotation * 500, -200)
			area.rot_speed = rotation * randf_range(1, 3)
			area.fall_speed = 5
			area.scale = Vector2(1.5, 0.5)
			area.Squished = true
			see_saw_sprites.position.y += 20
			var PlatformMove = create_tween()
			PlatformMove.tween_property(see_saw_sprites, "position",
			Vector2(see_saw_sprites.position.x, see_saw_sprites.position.y - 20),
			0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			


func _on_can_shoot_timer_timeout() -> void:
	self.can_shoot = true


func _on_robot_animation_finished() -> void:
	robot.play("default")


func _on_robot_frame_changed() -> void:
	if robot.animation == "shoot":
		if robot.frame == 4:
			Shoot()

func Shoot():
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
