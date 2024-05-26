shader_type spatial;

uniform float amt : hint_range(0.0, 1.0);
uniform sampler2D text;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (distance(UV, vec2(0.5,0.5)) > amt/2.0)
	{
		ALBEDO = vec4(0.0);
	}
	else
	{
		ALBEDO = texture(text, UV);
	}
}