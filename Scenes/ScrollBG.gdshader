shader_type canvas_item;

uniform float SpeedX = 0.1;
uniform float SpeedY = 0.1;

void vertex() {
	UV.x += TIME * SpeedX;
	UV.y += TIME * SpeedY;
}
