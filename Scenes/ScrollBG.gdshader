shader_type canvas_item;

uniform float Speed = 0.1;

void vertex() {
	UV.x += TIME * Speed;
	UV.y += TIME * Speed;
}
