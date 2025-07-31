extends Control

@onready var game_logo: Sprite2D = $GameLogo
var target_pos: Vector2 = Vector2(578.0, 180.0)
var CanSine: bool = false
var BaseY: float
var TimePassed: float

func _ready() -> void:
	LogoSpawn()

func _process(delta: float) -> void:
	if CanSine:
		LogoSine(delta)
	if Input.is_action_just_pressed("move_shoot"):
		get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func LogoSpawn():
	var LogoMove = create_tween()
	LogoMove.tween_property(game_logo, "position", target_pos, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	await LogoMove.finished
	BaseY = game_logo.position.y
	CanSine = true

func LogoSine(delta: float):
	TimePassed += delta
	game_logo.position.y = BaseY + sin(TimePassed * 1.0) * 25.0
