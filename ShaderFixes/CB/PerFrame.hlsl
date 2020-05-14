cbuffer CB_PerFrame : register(b13)
{
	float4 gCameraFadeAlpha : packoffset(c0);
	float4 gCameraFadeShadow : packoffset(c1);
	float4 gColorControl : packoffset(c2);
	float3 cBoostCol : packoffset(c3);
	float cHdrControl : packoffset(c3.w);
	float gAOControl : packoffset(c4);
}