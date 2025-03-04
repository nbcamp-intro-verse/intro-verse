#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
};

struct FrameConstants {
    float time;
    float2 resolution;
};

float opSmoothUnion(float d1, float d2, float k) {
    float h = clamp(0.5 + 0.5 * (d2 - d1)/k, 0.0, 1.0);
    return mix(d2, d1, h) - k * h * (1.0 - h);
}

float sdSphere(float3 p, float s) {
    return length(p) - s;
}

float map(float3 p, float time) {
    float d = 2.0;
    for (int i = 0; i < 8; i++) {
        float fi = float(i);
        float localTime = time * (fract(fi * 412.531 + 0.513) - 0.5) * 2.0;
        d = opSmoothUnion(
            sdSphere(p + sin(localTime + fi * float3(52.5126, 64.627444, 632.25) * float3(2.0, 2.0, 0.8)), mix(0.5, 1.0, fract(fi * 412.531 + 0.5124))),
                          d,
                          0.4
                          );
    }
    return d;
}

float3 calcNormal(float3 p, float time) {
    const float h = 1e-5;
    const float2 k = float2(1, -1);
    return normalize(k.xyy*map(p + k.xyy*h, time) +
                     k.yyx*map(p + k.yyx*h, time) +
                     k.yxy*map(p + k.yxy*h, time) +
                     k.xxx*map(p + k.xxx*h, time));
}

vertex VertexOut vertex_main(uint vertexID [[vertex_id]]) {
    float2 positions[6] = {
            float2(-1.0, -1.0), float2(1.0, -1.0), float2(-1.0, 1.0),
            float2(-1.0,  1.0), float2(1.0, -1.0), float2(1.0,  1.0)
        };
    
    VertexOut out;
    out.position = float4(positions[vertexID], 0.0, 1.0); // 클립 공간으로 변환
    return out;
}

fragment float4 fragment_main(float4 pos [[position]],
                              constant FrameConstants &constants [[buffer(0)]]) {
    float2 uv = pos.xy / constants.resolution;
    
    float3 rayOri = float3((uv - 0.5) * float2(constants.resolution.x / constants.resolution.y, 1.0) * 5.0, 3.0);
    float3 rayDir = float3(0.0, 0.0, -1.0);
    
    // Ray Marching
    float depth = 0.0;
    float3 p;
    
    for(int i = 0; i < 16; i++){
        p = rayOri + rayDir * depth;
        float dist = map(p, constants.time);
        if(dist < 1e-6){ break; }
        depth += dist;
    }
    
    depth = min(6.0, depth);
    float3 n = calcNormal(p, constants.time);
    float b = max(0.0, dot(n, float3(0.577)));
    
    float3 col = (0.5 + 0.5 * cos((b + constants.time * 3.0) + uv.xyx * 2.0 + float3(0, 2, 4))) * (0.85 + b * 0.35);
    col *= exp(-depth * 0.15);
    return float4(col, 1.0 - (depth - 0.5) / 2.0);
}
