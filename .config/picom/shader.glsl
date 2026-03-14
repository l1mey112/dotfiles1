#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);

    // Note: texture() is the correct standard for GLSL 330 instead of texture2D()
    vec4 color = texture(tex, texcoord / texsize);

    // --- Anti-Blue Light Filter Settings ---
    // RGB multipliers (1.0 = 100%, lower values reduce that color)
    // 
    // Presets to choose from:
    // vec3 night_color = vec3(1.0, 0.90, 0.75); // Light filtering (~5000K)
    // vec3 night_color = vec3(1.0, 0.82, 0.55); // Medium filtering (~4000K)
    vec3 night_color = vec3(1.0, 0.70, 0.28); // Heavy filtering (~3000K)

    //vec3 night_color = vec3(1.0, 0.82, 0.55); // Currently set to Medium

    // Tint the window by multiplying the RGB channels by our filter
    color.rgb *= night_color;

    // Apply the window opacity to all channels (RGBA)
    color *= opacity;

    return default_post_processing(color);
}

