cbuffer CB_PerPass : register(b12)
{
	float4 cAmbientColor : packoffset(c0);
	float3 cEnvMapAtten : packoffset(c1);
	float cSHScale : packoffset(c1.w);
}

#include "CB_PerCamera.hlsl"

#include "CB_PerObject.hlsl"

cbuffer CB_PerFogControl : register(b8)
{
	bool bFog : packoffset(c0);
	float4 cFog_Density_Start_Range : packoffset(c1);
	float4 cFogCol : packoffset(c2);
}

#include "CB_VS_ParticleTransforms.hlsl"

#include "3Dmigoto.hlsl"

#define EMBED_PARTICLES