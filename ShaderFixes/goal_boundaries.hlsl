#ifdef WRITE
  #define TYPE uniform RWStructuredBuffer
  #define REGBOUND u1
#else
  #define TYPE StructuredBuffer
  #define REGBOUND t14
#endif

TYPE<float> depth : register(REGBOUND);

#include "3Dmigoto.hlsl"

#define use_depth    ini(x,3)
#define tracker_type ini(w,3)
#define crosshair 1
#define execute_mark 2