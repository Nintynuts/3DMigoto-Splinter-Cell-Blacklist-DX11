cbuffer CB_PS_FullDeferredMaterial_Dynamic : register(b6)
{
  float4 cAlphaTest : packoffset(c0);
  float4x2 cTexTransform0 : packoffset(c1);
  float4x2 cTexTransform1 : packoffset(c3);
  float4x2 cTexTransform2 : packoffset(c5);
}