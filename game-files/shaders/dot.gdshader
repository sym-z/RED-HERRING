shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float dot_size = 7.0;
uniform float dot_contrast = 0.8;
void fragment() {
	COLOR = texture(screen_texture,SCREEN_UV);
	if (mod(FRAGCOORD.x,dot_size) <= 1. || mod(FRAGCOORD.y,dot_size) <= 1.)
	{
		COLOR *= vec4(dot_contrast,dot_contrast,dot_contrast,1.);
	}
	else if (mod(FRAGCOORD.x,dot_size/2.) <= 1. && mod(FRAGCOORD.y,dot_size/2.) <= 1.)
	{
		COLOR *= vec4(dot_contrast,dot_contrast,dot_contrast,1.);
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
