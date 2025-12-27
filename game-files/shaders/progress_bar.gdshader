shader_type canvas_item;
uniform float speed = 10.;
void vertex() {
	VERTEX.x += sin(TIME*speed);
	VERTEX.y += cos(TIME*speed);
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.rgb *= abs(cos(TIME)) + 1.0;
	//COLOR.r *= abs(sin(TIME));
	//COLOR.g *= abs(cos(TIME));
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
