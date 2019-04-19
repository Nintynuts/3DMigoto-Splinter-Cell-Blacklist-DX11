#ifdef WRITE
  #define TYPE uniform RWStructuredBuffer
  #define REGBOUND u1
#else
  #define TYPE StructuredBuffer
  #define REGBOUND t14
#endif

TYPE<float> depth : register(REGBOUND);