#define TEXTURE(type,name,sBuffer,tBuffer) \
SamplerState name##_s : register(s##sBuffer); \
type<float4> name : register(t##tBuffer)

#define TEXTURE_CMP(type,name,sBuffer,tBuffer) \
SamplerComparisonState name##_s : register(s##sBuffer); \
type<float4> name : register(t##tBuffer)

#define SAMPLE(name, pos) \
name.Sample(name##_s, pos)

#define SAMPLE_LVL(name, pos1, pos2) \
name.SampleLevel(name##_s, pos1, pos2)

#define SAMPLE_CMP_LVL(name, pos1, pos2) \
name.SampleCmpLevelZero(name##_s, pos1, pos2)

#define _2D Texture2D
#define _3D Texture3D
#define _Cube TextureCube