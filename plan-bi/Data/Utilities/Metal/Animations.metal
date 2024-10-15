//
//  Animations.metal
//  plan-bi
//
//  Created by Benjamin Moritz on 09.10.24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 wave(
                             float2 pos, float t
                             )
{
    pos.y *= sin(t * 5 + pos.y / 20) * 5;
    
    return pos;
}
