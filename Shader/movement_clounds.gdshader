shader_type canvas_item;

uniform float move_speed = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, vec2(UV.x + TIME * move_speed, UV.y));
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
