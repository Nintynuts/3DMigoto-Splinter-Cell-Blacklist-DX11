cbuffer CB_PerObject : register(b9)
{
	float4x3 gLocalToWorld : packoffset(c0);
	float4 gDrawScale : packoffset(c3);
	float4 cId : packoffset(c4);
	//float4 cSHParams[7] : packoffset(c5);
	float4x3 cMtx1 : packoffset(c5);
	float4x3 cMtx2 : packoffset(c8);
	float3 cExtra : packoffset(c11);
	float cAOID : packoffset(c12.x);
	bool bUseSH : packoffset(c12.y);
}