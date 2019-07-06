
#version 330

layout(location = 0) in vec3 a_vertex;
layout(location = 1) in vec3 a_velocity;
layout(location = 2) in float a_age;
layout(location = 3) in float a_life;


out vec3 v_vertex;
out vec3 v_velocity;
out float v_age;
out float v_life;

uniform mat4 u_mvp;
uniform mat4 u_model;
uniform mat4 u_vp;
uniform float u_time;

uniform float u_height_near_plane;

out float normalizedLife;

float random(vec2 co){
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy ,vec2(a,b));
    highp float sn = mod(dt,3.14);
    return fract(sin(sn) * c);
}

void main()
{
    float age = u_time - a_age;


    
    float pulseVelocity = 2.0f;
    float pulseSize = 2.0f * sin(u_time * 1.0f) + 0.5f*random(vec2(u_time, v_vertex));
    normalizedLife = 1-(age / a_life);

    if(age > a_life){
        
        float randomPosX = 100*random(vec2(u_time, v_vertex))-50;
        float randomPosY = 100*random(vec2(u_time, v_vertex+10))-50;


        v_vertex = vec3(randomPosX, 20, randomPosY);
        v_velocity = vec3(0, -50, 0);//vec3(pulseSize*sin(u_time * pulseVelocity)*cos(randomAngle), 3.5f+0.75f*random(vec2(u_time, v_vertex)),pulseSize*sin(u_time * pulseVelocity)* sin(randomAngle));
        v_age = u_time;
        v_life = a_life;
    }else{
        v_velocity = a_velocity - vec3(0, 0.5, 0);
        v_vertex = a_vertex + v_velocity * 0.005f;
        v_age = a_age;
        v_life = a_life;
    }
    

    gl_Position = u_vp * u_model * vec4(a_vertex, 1.0);
    
    gl_PointSize = 5.0;
    
}


/*
#version 330

layout(location = 0) in vec3 a_vertex;
layout(location = 1) in vec3 a_velocity;
layout(location = 2) in float a_age;
layout(location = 3) in float a_life;

out vec3 v_vertex;
out vec3 v_velocity;
out float v_age;
out float v_life;

uniform mat4 u_mvp;
uniform mat4 u_model;
uniform mat4 u_vp;
uniform float u_time;

uniform float u_height_near_plane;

out float normalizedLife;

float random(vec2 co){
	highp float a = 12.9898;
	highp float b = 78.233;
	highp float c = 43758.5453;
	highp float dt = dot(co.xy ,vec2(a,b));
	highp float sn = mod(dt,3.14);
	return fract(sin(sn) * c);
}

void main()
{
    float age = u_time - a_age;

    float randomAngle = 360.0f * random(vec2(u_time, v_vertex));
    float pulseVelocity = 2.0f;
    float pulseSize = 2.0f * sin(u_time * 1.0f) + 0.5f*random(vec2(u_time, v_vertex));
    normalizedLife = 1-(age / a_life);

    if(age > a_life){
        //reset particle
        v_vertex = vec3(0);
        v_velocity = vec3(pulseSize*sin(u_time * pulseVelocity)*cos(randomAngle), 3.5f+0.75f*random(vec2(u_time, v_vertex)),pulseSize*sin(u_time * pulseVelocity)* sin(randomAngle));
        v_age = u_time;
        v_life = a_life;
    }else{
        v_velocity = a_velocity - vec3(0, 0.005, 0);
        v_vertex = a_vertex + v_velocity * 0.005f;
        v_age = a_age;
        v_life = a_life;
    }
    

    gl_Position = u_vp * u_model * vec4(a_vertex, 1.0);
    
    gl_PointSize = 5.0;
    
}
*/