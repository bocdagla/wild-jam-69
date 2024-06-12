shader_type spatial;

uniform sampler2D tex : source_color;  // Texture, used as color
uniform sampler2D tex2 : source_color;  // Texture, used as color
uniform sampler2D transparency : source_color;  // Texture, used as color
uniform sampler2D noise_tex;  // Texture, used as color

void fragment() {
	vec3 noise = texture(noise_tex, UV).rgb;
    ALPHA = texture(transparency, UV).a;
    ALBEDO = mix(texture(tex, UV).rgb, texture(tex2,UV).rgb, noise.r); // Set the albedo to the texture color
}