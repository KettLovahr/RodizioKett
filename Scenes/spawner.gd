extends Node2D
class_name Spawner

var timer: Timer
var block_scene: PackedScene = preload("res://Scenes/Block.tscn")

var spawned_block_fall_speed: float = 5:
	set(v):
		spawned_block_fall_speed = v
		
var evil_chance: float = 0.1
var evil_health: int = 1

var spawn_delay: float = 2:
	set(v):
		timer.start(spawn_delay)
		spawn_delay = v

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.start(spawn_delay)
	timer.timeout.connect(spawn_random)

func spawn_random():
	var block: Block = block_scene.instantiate()
	if randf() < evil_chance:
		block.fall_speed = 1
		block.color = Block.BlockColor.EVIL
		block.health = evil_health
	else:
		block.fall_speed = spawned_block_fall_speed
		block.color = [Block.BlockColor.PINK, Block.BlockColor.GREEN][randi() % 2]
	add_child(block)
