extends Area2D
class_name ScoreArea

@export var preferred_color: Block.BlockColor
@export var scene_manager: MainScene
@onready var pink_icon: Sprite2D = $"../PinkIcon"
@onready var green_icon: Sprite2D = $"../GreenIcon"

func _ready():
	area_entered.connect(_on_area_entered)
	pink_icon.scale.x = 0.0
	green_icon.scale.x = 0.0
func _on_area_entered(area:Area2D):
	if area is Block:
		if area.color == preferred_color and area.color != Block.BlockColor.EVIL:
			scene_manager.score += 1
			var ColorThing = create_tween()
			var WhichOne: Sprite2D
			match preferred_color:
				0:
					pink_icon.scale.x = 4.75
					WhichOne = pink_icon
				1:
					green_icon.scale.x = 4.75
					WhichOne = green_icon
			ColorThing.tween_property(WhichOne, "scale",
			Vector2(0, 4), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
			
			area.queue_free()
			match preferred_color:
				Block.BlockColor.PINK:
					%Indicator.color = Color.PINK
					%Indicator2.color = Color.PINK
				Block.BlockColor.GREEN:
					%Indicator.color = Color.GREEN
					%Indicator2.color = Color.GREEN
		else:
			scene_manager.lives -= 1
			%Indicator.color = Color.RED
			%Indicator2.color = Color.RED
			area.queue_free()
			$"../UILayer/RobotUI".play("default")
			$"../UILayer/RobotUI".frame = 0
