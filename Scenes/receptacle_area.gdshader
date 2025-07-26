shader_type canvas_item;

uniform vec3 color: source_color = vec3(0);

void vertex() {

}

void fragment() {
	COLOR = vec4(color, UV.y * COLOR.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
