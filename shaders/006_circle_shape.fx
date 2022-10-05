
void MainVS(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

float circleshape(float2 position, float radius)
{
    // (position.xy - 0.5) scales texture cooordinates from [0.0, 1.0] to [-0.5, 0.5]
    return step(radius, length(position.xy - 0.5));
}

void MainPS(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 position = TexCoord.xy;

    float3 color = 0.0;

    float circle = circleshape(position, 0.2);

    color = circle;

    FragColor = float4(color, 1.0);
}

technique _006_circle_shape
{
    pass
    {
        VertexShader = MainVS;
        PixelShader = MainPS;
        #if BUFFER_COLOR_BIT_DEPTH == 8
            SRGBWriteEnable = TRUE;
        #endif
    }
}
