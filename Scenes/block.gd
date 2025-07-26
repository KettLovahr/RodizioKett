extends Area2D
class_name Block

enum BlockColor {
	PINK,
	GREEN,
	EVIL
}

var color: BlockColor

var collided: bool = false

var velocity: Vector2
var fall_speed: float

var rot_speed: float

var health: int = 1:
	set(v):
		if v <= 0:
			queue_free()
		else:
			if health > v:
				velocity = Vector2(0, -500)
				fall_speed *= 2
				rot_speed = (randf() * 10) - 10
		health = v


func _ready() -> void:
	match color:
		BlockColor.PINK: modulate = Color.PINK
		BlockColor.GREEN: modulate = Color.GREEN
		BlockColor.EVIL:
			modulate = Color.RED
			collision_layer = 2 | 1

func _process(delta: float) -> void:
	velocity.y += fall_speed
	position += velocity * delta
	rotation += rot_speed * 2 * delta
