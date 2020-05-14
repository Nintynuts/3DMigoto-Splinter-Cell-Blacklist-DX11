#ifndef CB_PerCamera_DEFINED
#define CB_PerCamera_DEFINED

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
#endif