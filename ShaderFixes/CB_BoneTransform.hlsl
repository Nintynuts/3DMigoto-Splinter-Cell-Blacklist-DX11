#ifndef MORPH
#define MORPH b0
#endif

cbuffer CB_VS_Morphing : register(MORPH)
{
	float4 gForces : packoffset(c0);
}

cbuffer CB_BoneTransform : register(b2)
{
	float4 gBones[156] : packoffset(c0);
}

float3x4 get_bones_mtx(int4 indices, uint4 weight)
{
	float4 w = weight * 0.00392156886;
	int4 r0 = indices * 3;
	int4 r1 = mad(indices, 3, 1);
	int4 r2 = mad(indices, 3, 2);
	float3x4 BonesMtx;
	BonesMtx[0] = gBones[r0.x] * w.x + gBones[r0.y] * w.y + gBones[r0.z] * w.z + gBones[r0.w] * w.w;
	BonesMtx[1] = gBones[r1.x] * w.x + gBones[r1.y] * w.y + gBones[r1.z] * w.z + gBones[r1.w] * w.w;
	BonesMtx[2] = gBones[r2.x] * w.x + gBones[r2.y] * w.y + gBones[r2.z] * w.z + gBones[r2.w] * w.w;
	return BonesMtx;
}