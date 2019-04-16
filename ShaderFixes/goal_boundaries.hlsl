#ifdef WRITE
  #define TYPE uniform RWStructuredBuffer
  #define REGBOUND u1
#else
  #define TYPE StructuredBuffer
  #define REGBOUND t14
#endif

struct boundary
{
	float2 topLft;
	float2 btmRgt;
	float depth;
	float quad;
	float2 size;
};

struct BoundaryData
{
	boundary boundaries[10];
	float elementDepthCache[24];
};

TYPE<BoundaryData> GoalData : register(REGBOUND);

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
	output.x = dot(vec.xyzw, x_trans.xyzw);
	output.y = dot(vec.xyzw, y_trans.xyzw);
	return output;
}