extends Area2D
class_name Block

@onready var BoxSprites: AnimatedSprite2D = $BoxSprites
var Squished: bool = false

@onready var land_particles: GPUParticles2D = $LandParticles
@onready var land_particles_green: GPUParticles2D = $LandParticlesGreen
@onready var kill_particles: GPUParticles2D = $KillParticles

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
			BoxSprites.visible = false
			kill_particles.emitting = true
			$CollisionShape2D.disabled = true
			await kill_particles.finished
			queue_free()
		else:
			if health > v:
				velocity = Vector2(0, -500)
				fall_speed *= 2
				rot_speed = (randf() * 10) - 10
		health = v


func _ready() -> void:
	match color:
		BlockColor.PINK: BoxSprites.play("Default")
		BlockColor.GREEN: BoxSprites.play("Green")
		BlockColor.EVIL:
			BoxSprites.play("EvilBox")
			collision_layer = 2 | 1

func _process(delta: float) -> void:
	print(Squished)
	velocity.y += fall_speed
	position += velocity * delta
	rotation += rot_speed * 2 * delta
	if Squished:
		match color:
			BlockColor.PINK: land_particles.emitting = true
			BlockColor.GREEN: land_particles_green.emitting = true
		var BoxScale = create_tween()
		BoxScale.tween_property(self, "scale", Vector2(1.0, 1.0), randf_range(0.1, 0.5)).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		Squished = false
