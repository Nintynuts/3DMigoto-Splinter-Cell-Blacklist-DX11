// Depth buffer copied from other shaders to this input with 3Dmigoto:

#include "CB_PerCamera.hlsl"
#include "3Dmigoto.hlsl"
#include "matrix.hlsl"

Texture2D<float4> sSceneDepth : register(t10);

float world_z_from_depth_buffer(float x, float y)
{
	uint width, height, samples = 0;
	float4 z;

	sSceneDepth.GetDimensions(width, height);

	x = min(max((x / 2 + 0.5) * width, 0), width - 1);
	y = min(max((-y / 2 + 0.5) * height, 0), height - 1);
	z.z = sSceneDepth.Load(int3(x, y, 0)).x;

	// Depth buffer scaling procedure copied from other shaders:
	z = mul(inverse(gProjection),float4(0, 0, z.z, 1));
	return z.w;
}

float adjust_from_depth_buffer(float x, float y)
{
	float old_offset, offset, w, sampled_w, distance;
	uint i;

	// Stereo cursor: To improve the accuracy of the stereo cursor, we
	// sample a number of points on the depth buffer, starting at the near
	// clipping plane and working towards original x + separation.
	//
	// You can think of this as a line in three dimensional space that
	// starts at each eye and stretches out towards infinity. We sample 255
	// points along this line (evenly spaced in the X axis) and compare
	// with the depth buffer to find where the line is first intersected.
	//
	// Note: The reason for sampling 255 points came from a restriction in
	// DX9/SM3 where loops had to run a constant number of iterations and
	// there was no way to set that number from within the shader itself.
	// I'm not sure if the same restriction applies in DX11 with SM4/5 - if
	// it doesn't, we could change this to check each pixel instead for
	// better accuracy.
	//
	// Based on DarkStarSword's stereo crosshair code originally developed
	// for Miasmata, adapted to Unity, then translated to HLSL.

	float min_depth = 100;
	offset = separation * (min_depth - convergence) / min_depth;
	//offset = -convergence * separation;	// Z = X offset from center
	//offset = clamp(x + offset, -1, 1) - x;
	distance = separation - offset;	// Total distance to cover (separation - starting X offset)

	old_offset = offset;
	for (i = 0; i < 255; i++) {
		offset += distance / 255.0;

		// Calculate depth for this point on the line:
		w = (separation * convergence) / (separation - offset);

		sampled_w = world_z_from_depth_buffer(x + offset, y);
		if (sampled_w == 0)
			return 0;

		// If the sampled depth is closer than the calculated depth,
		// we have found something that intersects the line, so exit
		// the loop and return the last point that was not intersected:
		if (w > sampled_w)
			break;

		old_offset = offset;
	}

	return old_offset;
}

float adjust_from_stereo2mono_depth_buffer(float x, float y)
{
	float old_offset, offset, w, left, right, left_sampled_w, right_sampled_w, sampled_w, distance;
	uint i;

	// Stereo cursor: To improve the accuracy of the stereo cursor, we
	// sample a number of points on the depth buffer, starting at the near
	// clipping plane and working towards original x + separation.
	//
	// You can think of this as a line in three dimensional space that
	// starts at each eye and stretches out towards infinity. We sample 255
	// points along this line (evenly spaced in the X axis) and compare
	// with the depth buffer to find where the line is first intersected.
	//
	// This particular variant uses the depth information from both eyes
	// (using 3DMigoto's stereo2mono feature) so we can find where the
	// lines from both eyes are intersected simultaneously for a more
	// accurate adjustment.
	//
	// Note: The reason for sampling 255 points came from a restriction in
	// DX9/SM3 where loops had to run a constant number of iterations and
	// there was no way to set that number from within the shader itself.
	// I'm not sure if the same restriction applies in DX11 with SM4/5 - if
	// it doesn't, we could change this to check each pixel instead for
	// better accuracy.
	//
	// Based on DarkStarSword's stereo crosshair code originally developed
	// for Miasmata, adapted to Unity, translated to HLSL, then updated to
	// make use of 3DMigoto's stereo2mono feature.

	float asep = abs(separation);
	float min_depth = IniParams.Load(0).y;

	offset = (min_depth - convergence) * asep;	// Z = X offset from center
	if (min_depth) // Avoid divide by 0
		offset /= min_depth;
	distance = asep - offset;			// Total distance to cover (asep - starting X offset)

	old_offset = offset;
	for (i = 0; i < 255; i++) {
		offset += distance / 255.0;

		// Calculate depth for this point on the line:
		w = (asep * convergence) / (asep - offset);

		float left = max((x - offset) / 2 + 0.5, 0);
		float right = min((x + offset) / 2 - 0.5, 0);

		left_sampled_w = world_z_from_depth_buffer(left, y);
		right_sampled_w = world_z_from_depth_buffer(right, y);

		// Only adjust the crosshair once it has intersected something in *both* eyes:
		sampled_w = max(left_sampled_w, right_sampled_w);

		// Adjust crosshair in both eyes once it intersects something in *either* eye:
		//sampled_w = min(left_sampled_w, right_sampled_w);

		// Equivalent to normal auto depth adjustment for a regular stereo depth buffer:
		//sampled_w = world_z_from_depth_buffer(x + offset * -eye, y);

		// Equivalent to normal auto depth adjustment for a 2x width mono depth buffer:
		//sampled_w = world_z_from_depth_buffer((x + offset * -eye) / 2 - 0.5 * -eye, y);

		if (sampled_w == 0)
			return 0;

		// If the sampled depth is closer than the calculated depth,
		// we have found something that intersects the line, so exit
		// the loop and return the last point that was not intersected:
		if (w > sampled_w)
			break;

		old_offset = offset;
	}

	return old_offset * -eye;
}
