cbuffer CB_VS_ColorPalette : register(b4)
{
	float4 cColorPalette[16] : packoffset(c0);
	bool bUseColorPalette : packoffset(c16);
}