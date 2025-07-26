extends Node2D
class_name MainScene

@export var score_label: Label
@export var lives_label: Label
@export var difficulties: Array[DifficultyRule]

var dead: bool = false
signal died

var lives: int = 3:
	set(v):
		var spawner: Spawner = $Spawner
		lives = v if v <= 10 else 10
		lives = lives if lives > 0 else 0
		lives_label.text = "Vidas: %s" % [lives]
		spawner.evil_chance = lives * 0.02
		if lives == 0:
			if not dead:
				print("You're dead.")
				died.emit()
				dead = true

var score: int = 0:
	set(v):
		score = v
		score_label.text = "%s" % [v]
		if v % 10 == 0 and not dead:
			self.lives += 1
		$SeeSaw.switch_speed = 0.1 + min(0.6, score / 500.0)
		print($SeeSaw.switch_speed)
		for diff in difficulties:
			var spawner: Spawner = $Spawner
			if diff.score_requirement == v:
				spawner.spawned_block_fall_speed = diff.fall_speed
				spawner.spawn_delay = diff.spawn_timer
				print("speed up! %s %s" % [diff.fall_speed, diff.spawn_timer])
				break


func _on_spawner_game_over() -> void:
	$UILayer/UIRoot/GameOverOverlay/GameOverScoreLabel.text = "Pontos: %d" % [score]
	$UILayer/UIRoot/GameOverOverlay.show()


func _on_try_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
