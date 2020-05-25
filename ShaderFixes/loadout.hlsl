#include "CB/PerCamera.hlsl"
#include "matrix.hlsl"
#include "3Dmigoto.hlsl"

#define fix_mode 1

#ifndef in_loadout
#define in_loadout gWorldToView[2][0] > 0.9
#endif

float4x4 reorientate(float4x4 worldToProj){
	if (fix_mode == 0 && in_loadout){
		worldToProj = mul(rotation_y_matrix(PI/2.0), worldToProj);
		worldToProj = mul(worldToProj, inverse(gProjection));
		float4x4 proj = gProjection;
		// resize aspect ratio
		proj[0][0] *= 2;
		proj[1][1] /= 2;
		worldToProj = mul(worldToProj, proj);
	}
	return worldToProj;
}

void stereo_fix_y(inout float4 vertex, bool no_convergence = false){
	vertex.y -= separation * ((vertex.w == 1? vertex.z : vertex.w) - (no_convergence ? 0 : convergence));
}

void stereo_unfix_y(inout float4 vertex, bool no_convergence = false){
	vertex.y += separation * ((vertex.w == 1? vertex.z : vertex.w) - (no_convergence ? 0 : convergence));
}

float4 reorientate(float4 vertex){
	if (fix_mode == 1 && in_loadout){
		stereo_fix_y(vertex);
		stereo_unfix(vertex);
	}
	return vertex;
}

void stereo_fix_(inout float4 vertex, bool no_convergence = false){
	if (fix_mode == 1 && in_loadout)
		stereo_fix_y(vertex, no_convergence);
	else
		stereo_fix(vertex, no_convergence);
}

void stereo_unfix_(inout float4 vertex, bool no_convergence = false){
	if (fix_mode == 1 && in_loadout)
		stereo_unfix_y(vertex, no_convergence);
	else
		stereo_unfix(vertex, no_convergence);
}

float4 swap_xy(float4 vertex){
	if (fix_mode == 2 && in_loadout){
		vertex.xy = vertex.yx;
		vertex.x -= 0.5;
		vertex.y += 0.5;
	}
	return vertex;
}