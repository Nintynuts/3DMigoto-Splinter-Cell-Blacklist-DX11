cbuffer CB_FullDeferredScene_Vertex : register(b2)
{
  float4 cSpec0 : packoffset(c0);
  float4 cSpec1 : packoffset(c1);
  float4 cBlend : packoffset(c2);
  float4 cDiffColor : packoffset(c3);
  float4 cDx11Padding1 : packoffset(c4);
  float4 cDx11Padding2 : packoffset(c5);
  float4 cStain : packoffset(c6);
}