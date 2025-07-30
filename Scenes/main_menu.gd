extends Control

@onready var game_logo: Sprite2D = $GameLogo
var target_pos: Vector2 = Vector2(578.0, 180.0)

func _ready() -> void:
	LogoSpawn()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_shoot"):
		get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func LogoSpawn():
	var LogoMove = create_tween()
	LogoMove.tween_property(game_logo, "position", target_pos, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
