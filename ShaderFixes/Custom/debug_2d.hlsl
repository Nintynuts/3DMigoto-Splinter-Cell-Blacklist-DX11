Texture1D<float4> IniParams : register(t120);

Texture2D<float4> StereoParams : register(t125);

#define amplify IniParams[0].x
#define flip IniParams[0].y

struct vs2ps {
	float4 pos : SV_Position0;
	float2 uv : TEXCOORD1;
};

#ifdef VERTEX_SHADER
void main(
		out vs2ps output,
		uint vertex : SV_VertexID)
{
	// Not using vertex buffers so manufacture our own coordinates.
	switch(vertex) {
		case 0:
			output.pos.xy = float2(-1, -1);
			break;
		case 1:
			output.pos.xy = float2(-1, 1);
			break;
		case 2:
			output.pos.xy = float2(1, -1);
			break;
		case 3:
			output.pos.xy = float2(1, 1);
			break;
		default:
			output.pos.xy = 0;
			break;
	};
	output.pos.zw = float2(0, 1);
	output.uv = output.pos.xy * float2(0.5,-0.5) + 0.5;
}
#endif

#ifdef PIXEL_SHADER

#include "..\matrix.hlsl"

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

Texture2D<float4> tex : register(t100);

void main(vs2ps input, out float4 result : SV_Target0)
{
	uint width, height;
	tex.GetDimensions(width, height);
	if (!width || !height)
		discard;

	if (flip)
		input.uv.y = 1 - input.uv.y;

		float4 stereo = StereoParams.Load(0);
	result = tex.Load(int3(input.uv.xy * float2(width, height), 0)).x;
	result = mul(inverse(gProjection),float4(0, 0, result.z, 1)).w / stereo.y;
	result /= 50;
}
#endif
