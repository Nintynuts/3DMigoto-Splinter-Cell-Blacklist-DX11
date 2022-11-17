#ifndef CB_PerCamera_DEFINED
#define CB_PerCamera_DEFINED
#include "3Dmigoto.hlsl"

cbuffer CB_PerCamera : register(b11)
{
	float4x4 gWorldToProj : packoffset(c0);
	float4x4 gWorldToView : packoffset(c4);
	float4x4 gProjection : packoffset(c8);
	float4 cProjSkinMesh : packoffset(c12);
	float4 gViewViewPos : packoffset(c13);
	float4 gHalfRenderTargetSize : packoffset(c14);
	float4 gVPTexelRes : packoffset(c15);
	float4 gViewportSB : packoffset(c16);
	float4 cViewPos_VS : packoffset(c17);
	float4 cViewPos : packoffset(c18);
	float2 gViewportOffset : packoffset(c19);
}

float3 CameraStereo(float3 pos){
	return pos.xyz + separation * convergence * gWorldToProj._m00_m10_m20 * mag(gWorldToProj._m00_m10_m20);
}

float3 cViewPosStereo(){
	return CameraStereo(cViewPos.xyz);
}

float4 cViewPosStereo_VS(){
	float4 cViewPos;
	cViewPos.xyz = CameraStereo(cViewPos_VS.xyz);
  	cViewPos.w = 1;
	return cViewPos;
}

#endif