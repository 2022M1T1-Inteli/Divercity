shader_type canvas_item;

vec4 texturePointSmooth(sampler2D tex, vec2 uv) { // Smooth texture sampling
	vec2 size = vec2(textureSize(tex, 0)); // Get texture size
	vec2 pixel = vec2(1.0) / size; // Get pixel size
	uv -= pixel * vec2(0.5); // Center the pixel
	vec2 uv_pixels = uv * size; // Convert to pixel units
	vec2 delta_pixel = fract(uv_pixels) - vec2(0.5); // Get the pixel offset
	vec2 ddxy = fwidth(uv_pixels); // Get the distance to the edge of the pixel
	vec2 mip = log2(ddxy) - 0.5; // Get the mip level
	return textureLod(tex, uv + (clamp(delta_pixel / ddxy, 0.0, 1.0) - delta_pixel) * pixel, min(mip.x, mip.y)); // Sample the texture
}

void fragment() { // Fragment shader
	vec4 Texture = texturePointSmooth(TEXTURE, UV); // Sample the texture
	COLOR = Texture.rgba; // Set the color
}
