#include "CB/PerCamera.hlsl"
#include "matrix.hlsl"
#include "3Dmigoto.hlsl"

#ifndef in_loadout
#define in_loadout gWorldToView[2][0] > 0.9
#endif

void stereo_fix_y(inout float4 vertex, bool no_convergence = false){
	vertex.y -= separation * ((vertex.w == 1? vertex.z : vertex.w) - (no_convergence ? 0 : convergence));
}

void stereo_unfix_y(inout float4 vertex, bool no_convergence = false){
	vertex.y += separation * ((vertex.w == 1? vertex.z : vertex.w) - (no_convergence ? 0 : convergence));
}

float4 reorientate(float4 vertex){
	if (in_loadout){
		stereo_fix_y(vertex);
		stereo_unfix(vertex);
	}
	return vertex;
}

void stereo_fix_(inout float4 vertex, bool no_convergence = false){
	if (in_loadout)
		stereo_fix_y(vertex, no_convergence);
	else
		stereo_fix(vertex, no_convergence);
}

void stereo_unfix_(inout float4 vertex, bool no_convergence = false){
	if (in_loadout)
		stereo_unfix_y(vertex, no_convergence);
	else
		stereo_unfix(vertex, no_convergence);
}