#ifndef DEFINED_3Dmigoto
#define DEFINED_3Dmigoto

// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);

#define ini(axis,num) IniParams.Load(int2(num,0)).axis

#define separation StereoParams.Load(0).x
#define convergence StereoParams.Load(0).y
#define eye StereoParams.Load(0).z

void stereo_fix(inout float4 vertex, bool no_convergence = false) 
{ vertex.x += separation * ((vertex.w == 1? vertex.z : vertex.w) - (no_convergence ? 0 : convergence)); }
void stereo_unfix(inout float4 vertex, bool no_convergence = false) 
{ vertex.x -= separation * ((vertex.w == 1? vertex.z : vertex.w) - (no_convergence ? 0 : convergence)); }

#define rt_width   ini(x,0)
#define rt_height  ini(y,0)
#define res_width  ini(z,0)
#define res_height ini(w,0)

bool rt_res_size_match() { return rt_width == res_width && rt_height == res_height; }

#define texture_filter ini(x,2)
#define gui_depth      ini(z,2)
#define menu_open      ini(w,2)

void gui_element(inout float4 vertex, float layer, float magnitude) { vertex.x -= separation * gui_depth * (layer - 5) * magnitude; }

float sq_mag(float2 input) { return dot(input, input); }
float mag(float2 input) { return rsqrt(sq_mag(input)); }
float2 normalise(float2 input) { return input * mag(input); }

float sq_mag(float3 input) { return dot(input, input); }
float mag(float3 input) { return rsqrt(sq_mag(input)); }
float3 normalise(float3 input) { return input * mag(input); }
#endif