shader_type spatial;

uniform vec4 primary_color: source_color;

stencil_mode read, compare_always, 1;
uniform float roughness = 0.2;

void vertex() {
	
}

void fragment() {
	ALBEDO = primary_color.rgb;
    ROUGHNESS = roughness;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
