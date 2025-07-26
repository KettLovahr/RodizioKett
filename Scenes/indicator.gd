extends ColorRect

func _process(_delta):
	if color != Color.BLACK:
		color = color.lerp(Color.BLACK, 0.1)
