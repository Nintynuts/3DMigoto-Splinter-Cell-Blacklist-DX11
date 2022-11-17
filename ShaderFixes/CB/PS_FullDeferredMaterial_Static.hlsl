cbuffer CB_PS_FullDeferredMaterial_Static : register(b7)
{
  float4 cDeferredMaterialProps : packoffset(c0);
  float4 cDiffCol : packoffset(c1);
  float4 cSpecCol : packoffset(c2);
  float4 cEnvCol : packoffset(c3);
  float4 cDBlendCol : packoffset(c4);
  float4 data0 : packoffset(c5);
  float4 data1 : packoffset(c6);
  float4 cDx11Padding : packoffset(c7);
  bool bEnvPass : packoffset(c8.x);
  bool bFresnel : packoffset(c8.y);
}