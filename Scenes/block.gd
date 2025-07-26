extends Area2D
class_name Block

enum BlockColor {
	PINK,
	GREEN,
	NONE
}

var color: BlockColor

var collided: bool = false

var velocity: Vector2
var fall_speed: float

var rot_speed: float


func _ready() -> void:
	match color:
		BlockColor.PINK: modulate = Color.PINK
		BlockColor.GREEN: modulate = Color.GREEN

func _process(delta: float) -> void:
	velocity.y += fall_speed
	position += velocity * delta
	rotation += rot_speed * 2 * delta
