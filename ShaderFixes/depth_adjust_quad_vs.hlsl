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

#include "goal_boundaries.hlsl"

struct Vertex
{
	uint pos; // R16G16_SINT
	uint colour; // R8G8B8A8_UNORM
#ifdef TEXT
	uint colour2; // R8G8B8A8_UNORM
	float2 uv;
#endif
};

StructuredBuffer<Vertex> VertexBuffer : register(t13);

#include "D3DX_DXGIFormatConvert.inl"

int2 getVertexPosition(uint index)
{
	return D3DX_R16G16_SINT_to_INT2(VertexBuffer[index].pos);
}

float2 transform(uint quad, uint vertex, float4 x_trans, float4 y_trans)
{
	float4 vec;
	vec.xy = getVertexPosition(quad+vertex);
	vec.zw = float2(0,1);
	float2 output;
	output.x = dot(vec, x_trans);
	output.y = dot(vec, y_trans);
	return output;
}

#include "3Dmigoto.hlsl"

void main(
#ifdef BATCHED
	float4 v1 : COLOR0,
#endif
	uint vID : SV_VertexID,
	out float4 o0 : SV_Position0,
	out float2 centre : TEXCOORD0)
{
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
		default: o0 = 0; break;
	}

	if (texture_filter == -1)
	{
		centre = 0;
		return;
	}

	float2 topLft = transform(quad,0,x_trans,y_trans);
	float2 btmRgt = transform(quad,3,x_trans,y_trans);
	centre = (topLft + btmRgt)/2;

	if (texture_filter == -3)
		centre.y -= 0.1;

	return;
}