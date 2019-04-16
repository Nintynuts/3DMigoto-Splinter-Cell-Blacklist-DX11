#define WRITE
#include "goal_boundaries.hlsl"

// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);

void main(float4 v0 : SV_Position0,
	float2 topLft : TEXCOORD0,
	float2 btmRgt : TEXCOORD1,
	float2 depth : TEXCOORD2,
	float2 size : TEXCOORD3,
	out float4 o0 : SV_Target0)
{	
	o0 = 1;

	if (false) // For testing
	{
		#define boundary GoalData[0].boundaries[0]
		boundary.topLft = topLft;
		boundary.btmRgt = btmRgt;
		boundary.depth = depth.x;
		boundary.quad = depth.y;
		boundary.size = size;
		#undef boundary

		return;
	}

	uint i;
	int quad = depth.y;

	for (i = 0; i < 10; i++)
	{
		boundary goal = GoalData[0].boundaries[i];
		
		if (quad < 0) // Background
		{
			if (all(goal.topLft == topLft)
				&& all(goal.btmRgt == btmRgt))
				return;
			if (all(goal.topLft == 0)
				&& all(goal.btmRgt == 0))
				break;
		}
		else // Other element
		{
			float2 center = (topLft + btmRgt)/2;
			if (center.x >= goal.topLft.x && center.x <= goal.btmRgt.x
				&& center.y >= goal.topLft.y && center.y <= goal.btmRgt.y)
				break;
		}
	}
	
	if (quad < 0) // Background
	{
		#define boundary GoalData[0].boundaries[i]
		boundary.topLft = topLft;
		boundary.btmRgt = btmRgt;
		boundary.depth = depth.x;
		boundary.quad = depth.y;
		boundary.size = size;
		#undef boundary

		for (int j = i; j < 24;j++)
			GoalData[0].elementDepthCache[j] = 0;
	}

	GoalData[0].elementDepthCache[abs(quad)-1] = i == 10 ? 0 : GoalData[0].boundaries[i].depth;

	return;
}