cbuffer CB_PerObject : register(b9)
{
	float4x3 gLocalToWorld : packoffset(c0);
	float4 gDrawScale : packoffset(c3);
	float4 cId : packoffset(c4);
	float4 cSHParams[7] : packoffset(c5);
	float cAOID : packoffset(c12);
	bool bUseSH : packoffset(c12.y);
}