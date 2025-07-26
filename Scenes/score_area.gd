extends Area2D
class_name ScoreArea

@export var preferred_color: Block.BlockColor
@export var scene_manager: MainScene

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area:Area2D):
	if area is Block:
		if area.color == preferred_color and area.color != Block.BlockColor.EVIL:
			scene_manager.score += 1
			area.queue_free()
			match preferred_color:
				Block.BlockColor.PINK: %Indicator.color = Color.PINK
				Block.BlockColor.GREEN: %Indicator.color = Color.GREEN
		else:
			scene_manager.lives -= 1
			%Indicator.color = Color.RED
			area.queue_free()
