extends Node2D
class_name MainScene

@export var score_label: Label
@export var lives_label: Label
@export var difficulties: Array[DifficultyRule]

var lives: int = 3:
	set(v):
		var spawner: Spawner = $Spawner
		lives = v if v <= 10 else 10
		lives = lives if lives > 0 else 0
		lives_label.text = "Vidas: %s" % [lives]
		spawner.evil_chance = lives * 0.02
		if lives == 0:
			spawner.timer.stop()


var score: int = 0:
	set(v):
		score = v
		score_label.text = "%s" % [v]
		if v % 10 == 0:
			self.lives += 1
		for diff in difficulties:
			var spawner: Spawner = $Spawner
			if diff.score_requirement == v:
				spawner.spawned_block_fall_speed = diff.fall_speed
				spawner.spawn_delay = diff.spawn_timer
				print("speed up!")
				break
