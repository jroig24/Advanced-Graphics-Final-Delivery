#version 330

//out color
out vec4 fragColor;
in float normalizedLife;

float lerp(float a, float b, float amount){
	return ((a-b)*amount)+a;
}

void main(){

	float processedLife = pow(normalizedLife, 1.0f);
    fragColor = vec4(0.0f, 0.0f, 1.0f, 1-processedLife);
}




