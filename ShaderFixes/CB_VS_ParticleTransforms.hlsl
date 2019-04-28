cbuffer CB_VS_ParticleTransforms : register(b6)
{
	bool bUseCubeMapAmbient : packoffset(c0);
	bool bUsePerpendicularFade : packoffset(c0.y);
	float4 cTextureProperties : packoffset(c1);
	float4 cSize_Offset : packoffset(c2);
	float4 cCamera_Position : packoffset(c3);
	float4 cCenter_Position : packoffset(c4);
	float4 cRotation_Offset : packoffset(c5);
	float4 cUseDirectionFrom : packoffset(c6);
	float4 cProjection_Front : packoffset(c7);
	float4 cProjection_Up : packoffset(c8);
	float4 cProjection_Right : packoffset(c9);
	float4 cAmbientMin : packoffset(c10);
	float4 cAmbientMax : packoffset(c11);
	float4 cFadeParms : packoffset(c12);
	float4 cBlendModeMask : packoffset(c13);
	float4x4 cAxisEffect : packoffset(c14);
	float4x4 cWorldToProj : packoffset(c18);
	float4x4 cViewToProj : packoffset(c22);
	float4x4 cL2W_Rot : packoffset(c26);
	float4 cCorners[4] : packoffset(c30);
}