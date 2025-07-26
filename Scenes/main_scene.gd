extends Node2D
class_name MainScene

@export var score_label: Label
@export var lives_label: Label
@export var difficulties: Array[DifficultyRule]

var lives: int = 3:
	set(v):
		lives = v
		lives_label.text = "Vidas: %s" % [v]

var score: int = 0:
	set(v):
		score = v
		score_label.text = "%s" % [v]
		for diff in difficulties:
			var spawner: Spawner = $Spawner
			if diff.score_requirement == v:
				spawner.spawned_block_fall_speed = diff.fall_speed
				spawner.spawn_delay = diff.spawn_timer
				print("speed up!")
				self.lives += 1
				break
