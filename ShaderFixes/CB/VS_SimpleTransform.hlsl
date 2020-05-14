cbuffer CB_VS_SimpleTransform : register(b3)
{
	float4x4 gSimpleWorldToProj : packoffset(c0);
}