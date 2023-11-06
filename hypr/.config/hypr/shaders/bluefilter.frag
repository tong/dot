// vim: set ft=glsl:

// https://reshade.me/forum/shader-discussion/3673-blue-light-filter-similar-to-f-lux

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);
    color[1] *= 0.855;
    color[2] *= 0.725;
    gl_FragColor = color;
}
