
void MainVS(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

float circleshape(float2 position, float radius)
{
    return step(radius, length(position - 0.5));
}

void MainPS(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 coord = TexCoord.xy;
    float3 color = 0.0;

    float2 transate = float2(1.0, -1.0);
    coord += transate * 0.5;

    color += circleshape(coord, 0.3);

    FragColor = float4(color, 1.0);
}

technique _009_translate
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
