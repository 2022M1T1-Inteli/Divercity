shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE,UV); // Get the color from the texture
	float grey = (color.r + color.g + color.b) * 0.333; // Calcule greyscale color (mean of red, green and blue)
	COLOR = vec4(grey, grey, grey, color.a); // Apply greyscale color (same for red, green and blue, then we keep the same alpha)
}