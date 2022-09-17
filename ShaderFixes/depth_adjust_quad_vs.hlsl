// Depth sample quad

#include "CB/VS_Scaleform.hlsl"

#include "markers.hlsl"

struct Vertex
{
	uint pos; // R16G16_SINT
	uint colour; // R8G8B8A8_UNORM
};

StructuredBuffer<Vertex> VertexBuffer : register(t13);

#include "D3DX_DXGIFormatConvert.inl"

int2 getPosition(uint index)
{
	return D3DX_R16G16_SINT_to_INT2(VertexBuffer[index].pos);
}

int2 getVertex(uint quad, uint vertex)
{
	return getPosition((quad * 6) + vertex);
}

void main(
#ifdef BATCHED
	float4 v1 : COLOR0,
#endif
	uint vID : SV_VertexID,
	out float4 o0 : SV_Position0,
	out float2 centre : TEXCOORD0,
	out uint quad : TEXCOORD1)
{
	#ifdef BATCHED
		uint vertex = vID % 6;
		quad = quad_id(vID);
		float4x4 trans = sf[quad].pos;
	#else
		uint vertex = vID;
		quad = 0;
		float4x4 trans = sf.pos;
	#endif

	switch (vertex)
	{
		case 0: o0 = float4(-1,-1,0,1); break;
		case 1: case 5: o0 = float4(1,-1,0,1); break;
		case 2: case 4: o0 = float4(-1,1,0,1); break;
		case 3: o0 = float4(1,1,0,1); break;
		default: o0 = 0; break;
	}

	if (marker_type == crosshair)
	{
		quad = 0;
		centre = float2(0,0.2);
		return;
	}

	float2 topLft = getVertex(quad,0);
	float2 btmRgt = getVertex(quad,3);
	float4 middle;
	middle.xy = (topLft + btmRgt)/2;
	middle.zw = float2(0,1);
	centre = mul(middle, trans).xy;

	if (marker_type == execute)
		centre.y -= 0.1;

	return;
}