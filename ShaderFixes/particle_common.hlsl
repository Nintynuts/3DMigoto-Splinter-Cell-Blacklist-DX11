#ifndef EMBED_PARTICLES // Removes method declaration when embedding

#include "particles.hlsl"

void particle_common(
	// Original input/output
	float4 v0,
	float4 v1,
	uint4 v2,
	float4 v3,
	float4 v4,
	int2 v5,
	out float4 o0,
	out float4 o1,
	out float4 o2,
	out float4 o3,
	out float4 o4,
	out float4 o5,
	// Values returned from method
	out float4 r1,
	out float4 r3, 
	out float4 r4, 
	out float4 r5, 
	out float4 r7,
	out float4 r11)
#endif
{
	float4 r0,r2,r6,r8,r9,r10;
	
	r0.xyz = v0.xyz;
	r0.w = 1;
	r1 = mul(r0, cAxisEffect);
	r0 = -cCamera_Position + r1;
	r0.x = dot(r0, cProjection_Front);
	r0.x = saturate(r0.x * cFadeParms.z + cFadeParms.w);
	r0.y = cmp(0 < r0.x);
	if (r0.y != 0) {
		r2 = (uint4)v2;
		r0.y = v5.x;
		r0.zw = cCorners[r0.y].xy - cSize_Offset.xy;
		r3 = cCorners[r0.y].zwzw * cTextureProperties.xyxy;
		o3 = r2 * cTextureProperties.xyxy + r3;
		r2.xyz = v1.zyx * 2 - 1;
		r0.y = cmp(cUseDirectionFrom.x == 0.0);
		if (r0.y != 0) {
			r3.xyz = cProjection_Right.yzx * cProjection_Up.zxy;
			r3.xyz = cProjection_Up.yzx * cProjection_Right.zxy - r3.xyz;
			r3.xyz = normalise(r3.xyz);
			r4.xyz = cProjection_Up.xyz;
			r5.xyz = cProjection_Right.xyz;
		} else {
			r0.y = cmp(cUseDirectionFrom.x == 1.0);
			if (r0.y != 0) {
				r6.xy = cmp(0.57 < abs(r2.xy));
				r6.yzw = r6.y ? float3(0,0,1) : float3(1,0,0);
				r6.xyz = r6.x ? float3(0,1,0) : r6.yzw;
				r7.xyz = mul(r2.xyz, cL2W_Rot);
				r8.zxy = mul(r6.xyz, cL2W_Rot);
				r6.xyz = r8.xyz * r7.zxy;
				r6.xyz = r7.yzx * r8.yzx - r6.xyz;
				r4.xyz = normalise(r6.xyz);
				r6.xyz = r7.zxy * r4.yzx;
				r6.xyz = r7.yzx * r4.zxy - r6.xyz;
				r5.xyz = normalise(r6.xyz);
				r6.xyz = r5.yzx * r4.zxy;
				r6.xyz = r4.yzx * r5.zxy - r6.xyz;
				r3.xyz = normalise(r6.xyz);
				r2.xyz = r7.xyz;
			} else {
				r6.xyz = -cCamera_Position.zxy + r1.zxy;
				r7.xyz = cmp(cUseDirectionFrom.x == float3(2,3,9));
				r0.y = (int)r7.y | (int)r7.x;
				r0.y = (int)r7.z | (int)r0.y;
				if (r0.y != 0) {
					r4.xyz = mul(r2.xyz, cAxisEffect);
					r7.xyz = r4.zxy * r6.zxy;
					r7.xyz = r4.yzx * r6.xyz - r7.xyz;
					r5.xyz = normalise(r7.xyz);
					r7.xyz = r5.yzx * r4.zxy;
					r7.xyz = r4.yzx * r5.zxy - r7.xyz;
					r3.xyz = normalise(r7.xyz);
					r2.xyz = r4.xyz;
				} else {
					r7.xy = cmp(cUseDirectionFrom.x == float2(4,5));
					r0.y = (int)r7.y | (int)r7.x;
					if (r0.y != 0) {
						r7.xyz = mul(r2.xyz, cAxisEffect);
						r2.xyz = normalise(r7.xyz);
						r7.xyz = r2.xyz * r6.xyz;
						r7.xyz = r2.zxy * r6.yzx - r7.xyz;
						r7.xyz = normalise(r7.xyz);
						r0.y = 1 - cUseDirectionFrom.y;
						r8.xyz = r7.zxy * r0.y;
						r4.xyz = r2.xyz * cUseDirectionFrom.y + r8.xyz;
						r8.xyz = cUseDirectionFrom.y * r7.zxy;
						r5.xyz = r2.xyz * r0.y + r8.xyz;
						r8.xyz = r7.xyz * r2.zxy;
						r7.xyz = r2.yzx * r7.yzx - r8.xyz;
						r3.xyz = normalise(r7.xyz);
					} else {
						r7.xyz = cmp(cUseDirectionFrom.x == float3(6,7,8));
						r0.y = (int)r7.y | (int)r7.x;
						r7.xyw = r6.xyz * r2.xyz;
						r6.xyz = r2.zxy * r6.yzx - r7.xyw;
						r6.xyz = normalise(r6.xyz);
						r2.w = 1 - cUseDirectionFrom.y;
						r7.xyw = r6.zxy * r2.w;
						r7.xyw = r2.xyz * cUseDirectionFrom.y + r7.xyw;
						r8.xyz = cUseDirectionFrom.y * r6.zxy;
						r8.xyz = r2.xyz * r2.w + r8.xyz;
						r9.xyz = r6.xyz * r2.zxy;
						r6.xyz = r2.yzx * r6.yzx - r9.xyz;
						r6.xyz = normalise(r6.xyz);
						r9.xyz = float3(0,1,0) * r2.zxy;
						r9.xyz = r2.yzx * float3(1,0,0) - r9.xyz;
						r9.xyz = normalise(r9.xyz);
						r10.xyz = r9.zxy * r2.yzx;
						r10.xyz = r9.yzx * r2.zxy - r10.xyz;
						r10.xyz = normalise(r10.xyz);
						r11.xyz = r10.zxy * r9.yzx;
						r11.xyz = r10.yzx * r9.zxy - r11.xyz;
						r11.xyz = normalise(r11.xyz);
						r10.xyz = r7.z ? r10.xyz : 0;
						r9.xyz = r7.z ? r9.xyz : 0;
						r11.xyz = r7.z ? r11.xyz : 0;
						r4.xyz = r0.y ? r7.xyw : r10.xyz;
						r5.xyz = r0.y ? r8.xyz : r9.xyz;
						r3.xyz = r0.y ? r6.xyz : r11.xyz;
					}
				}
			}
		}
		r5.xyz = v3.x * r5.xyz;
		r4.xyz = v3.y * r4.xyz;
		r6.xyz = r4.xyz * r0.z;
		r4.xyz = r6.xyz * cRotation_Offset.x + r4.xyz;
		r6.xyz = r5.xyz * r0.w;
		r5.xyz = r6.xyz * cRotation_Offset.y + r5.xyz;
		r0.y = 1 - v3.w;
		r6 = r3.xyzx * r3.xyzy;
		r7.xy = r3.zy * r3.xz;
		r8.xyz = v3.z * r3.yzx;
		r9.x = r6.w * r0.y + r8.y;
		r10.x = r6.w * r0.y - r8.y;
		r10.yz = r7.yx * r0.y + r8.zx;
		r9.yz = r7.xy * r0.y - r8.xz;
		r6.xyz = r6.xyz * r0.y + v3.w;
		r10.w = r6.x;
		r7.x = dot(r4.yzx, r10.xzw);
		r9.w = r6.y;
		r7.y = dot(r4.xzy, r9.xzw);
		r6.x = r9.y;
		r6.y = r10.y;
		r7.z = dot(r4.xyz, r6.xyz);
		r4.x = dot(r5.yzx, r10.xzw);
		r4.y = dot(r5.xzy, r9.xzw);
		r4.z = dot(r5.xyz, r6.xyz);
		r5.xyz = r0.z * r7.xyz + r1.xyz;
		r6.xyz = r4.xyz * r0.w;
		r5.w = r1.w;
		r6.w = 0;
		r11 = r5 + r6;
		r5 = mul(r11, cWorldToProj);
		o0 = r5;
		
		stereo_fix(r5);
		
		r6 = gViewportSB * r5.xyww;
		o4.xy = r6.xy + r6.zw;
		r0.yzw = cCamera_Position.xyz - r1.xyz;
		r0.yzw = normalise(r0.yzw);
		r0.y = dot(r0.yzw, r3.xyz);
		r0.z = dot(cProjection_Front.xyz, r3.xyz);
		r0.y = saturate(abs(r0.y) * abs(r0.z) - cFadeParms.x);
		r0.y = cFadeParms.y * r0.y;
		r0.y = r0.x * r0.y;
		r0.x = bUsePerpendicularFade ? r0.y : r0.x;
		r0.xy = saturate(cBlendModeMask.xy * r0.x + cBlendModeMask.yx);
		o1.w = v4.w * r0.y;		
	#ifndef SKIP_FOG
		r0.yzw = cViewPos_VS.xyz - r5.xyz;
		r0.y = dot(r0.yzw, r0.yzw);
		r0.y = sqrt(r0.y);
		r0.y = -cFog_Density_Start_Range.y + r0.y;
		r0.y = saturate(r0.y / cFog_Density_Start_Range.z);
		r0.y = cFog_Density_Start_Range.x * r0.y;
		o5.x = v0.w;
		o5.yz = 0;
		o5.w = bFog ? r0.y : 0;
	#endif		
		r8.xyz = mul(r2.xyz, gLocalToWorld);
		r2.xyz = normalise(r8.xyz);
		r2.w = 1;
		r8.xyz = mul(r2, cMtx1);
		r9 = r2.xyzz * r2.yzzx;
		r10.xyz = mul(r9, cMtx2);
		r0.y = r2.y * r2.y;
		r0.y = r2.x * r2.x - r0.y;
		r2.xyz = r10.xyz + r8.xyz;
		r0.yzw = cExtra * r0.y + r2.xyz;
		r0.yzw = max(0, r0.yzw);
		r0.yzw = cSHScale * r0.yzw;
		r0.yzw = bUseSH ? r0.yzw : cAmbientColor.xyz;
		r0.yzw = bUseCubeMapAmbient ? r0.yzw : 0;
		r0.yzw = max(cAmbientMin.xyz, r0.yzw);
		o2.xyz = min(cAmbientMax.xyz, r0.yzw);
		o2.w = r0.x;
		o4.z = v1.w;
		o4.w = r5.w;
		o1.xyz = v4.zyx;
	} else {
		o0 = float4(0,0,0,-1);
		o1 = 0;
		o2 = 0;
		o3 = 0;
		o4 = 0;
		o5 = 0;
	}
}