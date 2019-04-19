#ifndef DEFINED_3Dmigoto
#define DEFINED_3Dmigoto

// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);

#define separation StereoParams.Load(0).x
#define convergence StereoParams.Load(0).y
#define eye StereoParams.Load(0).z

void stereo_fix(inout float4 vertex) { vertex.x += separation * (vertex.w - convergence); }
void stereo_unfix(inout float4 vertex) { vertex.x -= separation * (vertex.w - convergence); }

#define texture_filter IniParams.Load(int2(2,0)).x

#endif