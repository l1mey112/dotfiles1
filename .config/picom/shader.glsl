#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);

    vec4 color = texture(tex, texcoord / texsize);

#if 0
	// mexico
    vec3 night_color = vec3(1.0, 0.70, 0.28);
    color.rgb *= night_color;
#else
	// greyscale
	float gray = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
	color = vec4(mix(color.rgb, vec3(gray), 0.7), color.a);
#endif


    color *= opacity;
    return default_post_processing(color);
}

