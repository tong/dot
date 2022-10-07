uniform sampler2D tex;
uniform float opacity;
uniform float time;
uniform bool invert_color;

const float compoVignetteStrength = 0.4;
const float compoGrainStrength = 0.05;
//const float chromatic_max_distort = 8.0;

void main() {

    vec2 texCoord = gl_TexCoord[0].xy;
	vec4 c = texture2D(tex, texCoord);

    if (invert_color)
		c = vec4(vec3(c.a, c.a, c.a) - vec3(c), c.a);

    // Grayscale
    float g = 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b;   // CIELAB luma, based on human tristimulus.
	c = vec4(vec3(g), c.a);
    
    // Chromatic Abberation
    /*
    vec3 col = vec3(0.0);
    col.x = texture(tex, texCoord + ((vec2(0.0, 1.0) * chromatic_max_distort) / vec2(1000.0))).x;
    col.y = texture(tex, texCoord + ((vec2(-0.85, -0.5) * chromatic_max_distort) / vec2(1000.0))).y;
    col.z = texture(tex, texCoord + ((vec2(0.85, -0.5) * chromatic_max_distort) / vec2(1000.0))).z;
    c = vec4(col.x, col.y, col.z, gl_FragColor.w);
    */

    // Vignette
    c.rgb *= (1.0 - compoVignetteStrength) + compoVignetteStrength * pow(16.0 * texCoord.x * texCoord.y * (1.0 - texCoord.x) * (1.0 - texCoord.y), 0.2);
   
    // Filmgrain
    float x = (texCoord.x + 4.0) * (texCoord.y + 4.0) * (time * 10.0);
    c.rgb += vec3(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01) - 0.005) * compoGrainStrength;

    c *= opacity;

    gl_FragColor = c;
}
