
void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

float rectshape(float2 position, float2 scale)
{
    scale = 0.5 - scale.xy * 0.5;
    float2 shaper = step(scale.xy, position.xy);
    shaper *= step(scale.xy, 1.0 - position.xy);
    return shaper.x * shaper.y;
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 position = TexCoord.xy;

    float3 color = 0.0;

    float rectangle = rectshape(position.xy, float2(0.3, 0.3));

    color = rectangle;

    FragColor = float4(color, 1.0);
}

technique _007_rect_shape
{
    pass
    {
        VertexShader = VS_Main;
        PixelShader = PS_Main;
        #if BUFFER_COLOR_BIT_DEPTH == 8
            SRGBWriteEnable = TRUE;
        #endif
    }
}
