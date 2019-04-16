// Depth Calculation and Caching for Goal Boundaries

#ifdef BATCHED
#define MVP_SIZE 192
#else
#define MVP_SIZE 8
#endif

cbuffer CB_VS_Scaleform : register(b7)
{	
	float4 mvp[MVP_SIZE] : packoffset(c0); 
}

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

// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);

#include "depth_adjust.hlsl" 
#include "goal_boundaries.hlsl"

void main(
#ifdef BATCHED
	float4 v1 : COLOR0,
#endif
	uint vID : SV_VertexID,
	out float4 o0 : SV_Position0,
	out float2 topLft : TEXCOORD0,
	out float2 btmRgt : TEXCOORD1,
	out float2 depth : TEXCOORD2,
	out float2 size : TEXCOORD3)
{
	o0 = 0;
	topLft = 0;
	btmRgt = 0;
	depth = 0;
	size = 0;
		
	float4 tex_filter = IniParams.Load(int2(2,0));

	if (tex_filter.x > -2)
		return;

#ifdef BATCHED
	uint vertex = vID % 6;
	uint quad = (vID - vertex)/6;
	float r0 = (int)(2040.01001 * v1.x);
	float4 x_trans = mvp[r0 + 0];
	float4 y_trans = mvp[r0 + 1];
#else
	uint vertex = vID;
	uint quad = 0;
	float4 x_trans = mvp[0];
	float4 y_trans = mvp[1];
#endif

	switch (vertex)
	{
		case 0: o0 = float4(-1,-1,0,1); break;
		case 1: case 5: o0 = float4(1,-1,0,1); break;
		case 2: case 4: o0 = float4(-1,1,0,1); break;
		case 3: o0 = float4(1,1,0,1); break;
	}
	
	topLft = transform(quad,0,x_trans,y_trans);
	btmRgt = transform(quad,3,x_trans,y_trans);
	depth.y = quad+1;	

	size = btmRgt - topLft;

	if (tex_filter.x == -2.5)
	{
		//if (size.x > 0.19)
		//{
		//	o0 = 0;
		//	topLft = 0;
		//	btmRgt = 0;
		//	size = 0;
		//}
		//else
		{
			float2 centre = (topLft + btmRgt)/2;
			depth.x = adjust_from_depth_buffer(centre.x,centre.y);
			depth.y *= -1;
		}
	}

	return;
}