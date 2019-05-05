#ifdef BATCHED
#define SF_SIZE [24]
#else
#define SF_SIZE
#endif

struct scaleform {
	float4x4 pos;
	float4x2 norm; // unsure
	float4x2 tex;
};

cbuffer CB_VS_Scaleform : register(b7)
{
	//float4 mvp[8] : packoffset(c0);
	scaleform sf SF_SIZE : packoffset(c0);
}