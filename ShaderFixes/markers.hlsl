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
  float chars;
};

TYPE<DepthData> markers : register(REGBOUND);

#include "3Dmigoto.hlsl"

#define use_depth    ini(x,3) == 1
#define marker_index ini(y,3)
#define num_chars    ini(z,3)
#define tracker_type ini(w,3)
static const int crosshair = 1;
static const int execute_mark = 2;

uint quad_id(uint vID) { return (vID - (vID % 6))/6; }