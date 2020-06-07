#define WRITE
#include "markers.hlsl"
#include "depth_adjust.hlsl" 

void main(
	float4 v0 : SV_Position0,
	float2 centre : TEXCOORD0,
	uint quad : TEXCOORD1,
	out float4 o0 : SV_Target0)
{	
	o0 = 1;

	uint idx = marker_index + quad;
	centre = (centre + 1)/2;
	centre.x *= res_width;
	centre.y *= res_height;
	markers[idx].screenPos = centre;
	markers[idx].depth = adjust_from_depth_buffer(centre.x,centre.y);
	markers[idx].chars = num_chars;

	return;
}