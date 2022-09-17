#ifdef BATCHED
#define SF_SIZE [24]
#else
#define SF_SIZE
#endif

struct scaleform {
	float4x4 pos;
	float4 other1;
	float4 other2;
	float4x2 tex;
};

cbuffer CB_VS_Scaleform : register(b7)
{
	scaleform sf SF_SIZE : packoffset(c0);
}