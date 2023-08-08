// vim: set ft=glsl:

precision mediump float;

varying vec2 v_texcoord;
uniform sampler2D tex;

const float R = 1.0;
const float G = 1.0;
const float B = 0.98;

void main() {
    vec4 col = texture2D(tex, v_texcoord);
    col[0] *= R;
    col[1] *= G;
    col[2] *= B;
    gl_FragColor = col;
}
