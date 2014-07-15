#ifdef UBO_DISABLED
uniform mat4 ViewMatrix;
uniform mat4 ProjectionMatrix;
uniform mat4 InverseViewMatrix;
uniform mat4 InverseProjectionMatrix;
#else
layout (std140) uniform MatrixesData
{
    mat4 ViewMatrix;
    mat4 ProjectionMatrix;
    mat4 InverseViewMatrix;
    mat4 InverseProjectionMatrix;
    mat4 ShadowViewProjMatrixes[4];
    vec2 screen;
};
#endif

uniform vec3 windDir;
uniform mat4 ModelMatrix;
uniform mat4 InverseModelMatrix;

#if __VERSION__ >= 330
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec4 Color;
layout(location = 3) in vec2 Texcoord;
#else
in vec3 Position;
in vec3 Normal;
in vec4 Color;
in vec2 Texcoord;
#endif

out vec3 nor;
out vec2 uv;

void main()
{
    uv = Texcoord;
    mat4 ModelViewProjectionMatrix = ProjectionMatrix * ViewMatrix * ModelMatrix;
    mat4 TransposeInverseModelView = transpose(InverseModelMatrix * InverseViewMatrix);
    nor = (TransposeInverseModelView * vec4(Normal, 1.)).xyz;
    gl_Position = ModelViewProjectionMatrix * vec4(Position + windDir * Color.r, 1.);
}
