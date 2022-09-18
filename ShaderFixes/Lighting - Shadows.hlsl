cbuffer CB_PS_Shadows : register(b7)
{
	float4 offsets[8] : packoffset(c0);
	float2 shadow_map_res : packoffset(c8);
	float4x4 cScreenToLight : packoffset(c9);
	float4 cShadowFade : packoffset(c13);
	float4 g_vShadowMapDimensions : packoffset(c14);
	float4 g_vCHSData : packoffset(c15);
}

cbuffer CB_PS_ShadowRender : register(b6)
{
	bool bFade : packoffset(c0.x);
	float4 cClip0 : packoffset(c1);
	float4 cClip1 : packoffset(c2);
	float4 cNoiseSB : packoffset(c3);
	float4 cScale : packoffset(c4);
	float4 cBias : packoffset(c5);
	float4 cVPSB : packoffset(c6);
	float4x4 cMaskScreenToLight : packoffset(c7);
	float4 cSpotLight : packoffset(c11);
}

#include "texture.hlsl"
TEXTURE(_2D,sSceneDepth,15,0);
#include "loadout.hlsl"
