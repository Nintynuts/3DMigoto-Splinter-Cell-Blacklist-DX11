#ifndef LIGHT_REG
#define LIGHT_REG b0
#endif

struct Omni
{
		float4 pos;
		float4 dCol;
		float4 sCol;
		float4 mask;
		float4 atten;
};

struct Spot
{
		float4 pos;
		float4 dCol;
		float4 sCol;
		float4 mask;
		float4 atten;
		float4x4 proj;
};

struct Dir
{
		float4 dir;
		float4 dCol;
		float4 sCol;
		float4 mask;
};

cbuffer CB_PS_PerLightBatch : register(LIGHT_REG)
{
		Omni cOmni0 : packoffset(c0);
		Omni cOmni1 : packoffset(c5);
		Omni cOmni2 : packoffset(c10);
		Omni cOmni3 : packoffset(c15);
		Spot cSpot0 : packoffset(c20);
		Spot cSpot1 : packoffset(c29);
		Spot cSpot2 : packoffset(c38);
		Dir cDir0 : packoffset(c47);

		bool bOmni0 : packoffset(c51.x);
		bool bOmni1 : packoffset(c51.y);
		bool bOmni2 : packoffset(c51.z);
		bool bOmni3 : packoffset(c51.w);
		bool bSpot0 : packoffset(c52.x);
		bool bSpot1 : packoffset(c52.y);
		bool bSpot2 : packoffset(c52.z);
		bool bDir0 : packoffset(c52.w);
}