#ifdef WRITE
  #define TYPE uniform RWStructuredBuffer
  #define REGBOUND u1
#else
  #define TYPE StructuredBuffer
  #define REGBOUND t14
#endif

struct DepthData {
  float2 screenPos;
  float depth;
  float type;
};

TYPE<DepthData> markers : register(REGBOUND);

#include "3Dmigoto.hlsl"

#define num_markers   ini(x,3)
#define marker_index  ini(y,3)
#define partial_chars ini(z,3)
#define use_depth     ini(w,3) != 0
#define marker_type   ini(w,3)
#define new_chars     ini(x,4)
static const int crosshair = 3;
static const int execute = 4;

uint quad_id(uint vID) { return (vID - (vID % 6))/6; }