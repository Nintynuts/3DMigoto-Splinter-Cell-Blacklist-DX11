cbuffer CB_PerPass : register(b12)
{
	float4 cAmbientColor : packoffset(c0);
	float3 cEnvMapAtten : packoffset(c1);
	float cSHScale : packoffset(c1.w);
}