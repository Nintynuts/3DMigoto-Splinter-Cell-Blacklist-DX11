#define WRITE
#include "goal_boundaries.hlsl"
#include "depth_adjust.hlsl" 

void main(float4 v0 : SV_Position0,
float2 centre : TEXCOORD0,
out float4 o0 : SV_Target0)
{	
	o0 = 1;

	depth[0] = adjust_from_depth_buffer(centre.x,centre.y);

	return;
}