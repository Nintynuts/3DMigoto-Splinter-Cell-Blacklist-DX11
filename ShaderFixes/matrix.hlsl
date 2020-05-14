matrix inverse(matrix m)
{
	matrix inv;

	float det = determinant(m);
	inv[0].x = m[1].y*(m[2].z*m[3].w - m[2].w*m[3].z) + m[1].z*(m[2].w*m[3].y - m[2].y*m[3].w) + m[1].w*(m[2].y*m[3].z - m[2].z*m[3].y);
	inv[0].y = m[0].y*(m[2].w*m[3].z - m[2].z*m[3].w) + m[0].z*(m[2].y*m[3].w - m[2].w*m[3].y) + m[0].w*(m[2].z*m[3].y - m[2].y*m[3].z);
	inv[0].z = m[0].y*(m[1].z*m[3].w - m[1].w*m[3].z) + m[0].z*(m[1].w*m[3].y - m[1].y*m[3].w) + m[0].w*(m[1].y*m[3].z - m[1].z*m[3].y);
	inv[0].w = m[0].y*(m[1].w*m[2].z - m[1].z*m[2].w) + m[0].z*(m[1].y*m[2].w - m[1].w*m[2].y) + m[0].w*(m[1].z*m[2].y - m[1].y*m[2].z);
	inv[1].x = m[1].x*(m[2].w*m[3].z - m[2].z*m[3].w) + m[1].z*(m[2].x*m[3].w - m[2].w*m[3].x) + m[1].w*(m[2].z*m[3].x - m[2].x*m[3].z);
	inv[1].y = m[0].x*(m[2].z*m[3].w - m[2].w*m[3].z) + m[0].z*(m[2].w*m[3].x - m[2].x*m[3].w) + m[0].w*(m[2].x*m[3].z - m[2].z*m[3].x);
	inv[1].z = m[0].x*(m[1].w*m[3].z - m[1].z*m[3].w) + m[0].z*(m[1].x*m[3].w - m[1].w*m[3].x) + m[0].w*(m[1].z*m[3].x - m[1].x*m[3].z);
	inv[1].w = m[0].x*(m[1].z*m[2].w - m[1].w*m[2].z) + m[0].z*(m[1].w*m[2].x - m[1].x*m[2].w) + m[0].w*(m[1].x*m[2].z - m[1].z*m[2].x);
	inv[2].x = m[1].x*(m[2].y*m[3].w - m[2].w*m[3].y) + m[1].y*(m[2].w*m[3].x - m[2].x*m[3].w) + m[1].w*(m[2].x*m[3].y - m[2].y*m[3].x);
	inv[2].y = m[0].x*(m[2].w*m[3].y - m[2].y*m[3].w) + m[0].y*(m[2].x*m[3].w - m[2].w*m[3].x) + m[0].w*(m[2].y*m[3].x - m[2].x*m[3].y);
	inv[2].z = m[0].x*(m[1].y*m[3].w - m[1].w*m[3].y) + m[0].y*(m[1].w*m[3].x - m[1].x*m[3].w) + m[0].w*(m[1].x*m[3].y - m[1].y*m[3].x);
	inv[2].w = m[0].x*(m[1].w*m[2].y - m[1].y*m[2].w) + m[0].y*(m[1].x*m[2].w - m[1].w*m[2].x) + m[0].w*(m[1].y*m[2].x - m[1].x*m[2].y);
	inv[3].x = m[1].x*(m[2].z*m[3].y - m[2].y*m[3].z) + m[1].y*(m[2].x*m[3].z - m[2].z*m[3].x) + m[1].z*(m[2].y*m[3].x - m[2].x*m[3].y);
	inv[3].y = m[0].x*(m[2].y*m[3].z - m[2].z*m[3].y) + m[0].y*(m[2].z*m[3].x - m[2].x*m[3].z) + m[0].z*(m[2].x*m[3].y - m[2].y*m[3].x);
	inv[3].z = m[0].x*(m[1].z*m[3].y - m[1].y*m[3].z) + m[0].y*(m[1].x*m[3].z - m[1].z*m[3].x) + m[0].z*(m[1].y*m[3].x - m[1].x*m[3].y);
	inv[3].w = m[0].x*(m[1].y*m[2].z - m[1].z*m[2].y) + m[0].y*(m[1].z*m[2].x - m[1].x*m[2].z) + m[0].z*(m[1].x*m[2].y - m[1].y*m[2].x);
	inv /= det;

	return inv;
}

matrix inverse(float4 m0, float4 m1, float4 m2, float4 m3)
{
	return inverse(matrix(m0, m1, m2, m3));
}

#define MATRIX(cb, idx) matrix(cb[idx], cb[idx+1], cb[idx+2], cb[idx+3])

matrix translation_matrix(float x, float y, float z)
{
	return matrix(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 1, 0,
				  x, y, z, 1);
}

matrix translation_matrix(float3 c)
{
	return translation_matrix(c.x, c.y, c.z);
}

matrix scale_matrix(float x, float y, float z)
{
	return matrix(x, 0, 0, 0,
				  0, y, 0, 0,
				  0, 0, z, 0,
				  0, 0, 0, 1);
}

matrix rotation_x_matrix(float radians)
{
	float s, c;

	sincos(radians, s, c);
	return matrix(1, 0, 0, 0,
				  0, c, s, 0,
				  0, -s, c, 0,
				  0, 0, 0, 1);
}

matrix rotation_y_matrix(float radians)
{
	float s, c;

	sincos(radians, s, c);
	return matrix(c, 0, -s, 0,
				  0, 1, 0, 0,
				  s, 0, c, 0,
				  0, 0, 0, 1);
}

matrix rotation_z_matrix(float radians)
{
	float s, c;

	sincos(radians, s, c);
	return matrix( c, s, 0, 0,
				  -s, c, 0, 0,
				   0, 0, 1, 0,
				   0, 0, 0, 1);
}

matrix identity()
{
	return matrix(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 1, 0,
				  0, 0, 0, 1);
}

bool is_identity(matrix m)
{
	return all(m == identity());
}

float3 mtx_to_euler(float4x4 mat)
{
	float3 euler;
	euler.x = asin(-mat._32);                  // Pitch
	if (cos(euler.x) > 0.0001)                 // Not at poles
	{
		euler.y = atan2(mat._31, mat._33);     // Yaw
		euler.z = atan2(mat._12, mat._22);     // Roll
	}
	else
	{
		euler.y = 0.0f;                        // Yaw
		euler.z = atan2(-mat._21, mat._11);    // Roll
	}
	return euler;
}

float4x4 euler_to_mtx(float3 euler)
{
	float cosY = cos(euler.y);     // Yaw
	float sinY = sin(euler.y);

	float cosP = cos(euler.x);     // Pitch
	float sinP = sin(euler.x);

	float cosR = cos(euler.z);     // Roll
	float sinR = sin(euler.z);

	float4x4 mat = identity();
	mat._11 = cosY * cosR + sinY * sinP * sinR;
	mat._21 = cosR * sinY * sinP - sinR * cosY;
	mat._31 = cosP * sinY;

	mat._12 = cosP * sinR;
	mat._22 = cosR * cosP;
	mat._32 = -sinP;

	mat._13 = sinR * cosY * sinP - sinY * cosR;
	mat._23 = sinY * sinR + cosR * cosY * sinP;
	mat._33 = cosP * cosY;
	return mat;
}

float4x4 m_scale(float4x4 m, float3 v)
{
	float x = v.x, y = v.y, z = v.z;

	m[0][0] *= x; m[1][0] *= y; m[2][0] *= z;
	m[0][1] *= x; m[1][1] *= y; m[2][1] *= z;
	m[0][2] *= x; m[1][2] *= y; m[2][2] *= z;
	m[0][3] *= x; m[1][3] *= y; m[2][3] *= z;

	return m;
}

float4x4 m_translate(float4x4 m, float3 v)
{
	float x = v.x, y = v.y, z = v.z;
	m[0][3] = x;
	m[1][3] = y;
	m[2][3] = z;
	return m;
}

float4x4 compose(float3 position, float3 rotation, float3 scale)
{
	float4x4 m = euler_to_mtx(rotation);
	m = m_scale(m, scale);
	m = m_translate(m, position);
	return m;
}

void decompose(in float4x4 m, out float3 position, out float3 rotation, out float3 scale)
{
	scale.x = length(m[0].xyz);
	scale.y = length(m[1].xyz);
	scale.z = length(m[2].xyz);

	// if determine is negative, we need to invert one scale
	float det = determinant(m);
	if (det < 0)
		scale.x *= -1;

	position = m[3].xyz;;

	// scale the rotation part

	m = m_scale(m,1.0/scale);

	rotation = mtx_to_euler(m);
}