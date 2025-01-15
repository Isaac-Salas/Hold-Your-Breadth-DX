shader_type canvas_item;
//uniform sampler2D smoke;
//uniform sampler2D screen : hint_screen_texture;
uniform float speed = 10.0;
uniform float distortion = 10.0;
uniform float stretch = 2.0;
varying float vertexsize;

////////////////works but not on animated
//void fragment(){
	//vec2 smoke_uv = UV + TIME * speed;
	//vec4 smoke_col = texture(smoke, fract(smoke_uv));
	//vec4 calculate = texture(TEXTURE, SCREEN_UV + vec2(smoke_col.g - size/2.0, 0.0));
	//COLOR = calculate;
//}
void vertex(){
	if (VERTEX.x > 0.0){
		VERTEX += vec2(sin((TIME*speed)+VERTEX.x+distortion), 0);
		//VERTEX.x *= 2.0;
		vertexsize = VERTEX.x;
		//VERTEX.x -= ((VERTEX.x) * 1.5);
	}

}