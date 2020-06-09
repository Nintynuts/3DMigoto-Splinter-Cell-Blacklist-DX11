cbuffer CB_PerFogControl : register(b8)
{
	bool bFog : packoffset(c0.x);
	float4 cFog_Density_Start_Range : packoffset(c1);
	float4 cFogCol : packoffset(c2);
}