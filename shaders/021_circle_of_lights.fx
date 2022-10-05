
void MainVS(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void MainPS(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 coord = TexCoord;
    float3 color = 0.0;
    float2 translate = float2(-0.5, -0.5);
    coord += translate;

    for(int i = 0; i < 40; i++)
    {
        float radius = 0.3;
        float rad = radians(360.0 / 40.0) * float(i);

        color += 0.003 / length(coord + float2(radius * cos(rad), radius * sin(rad)));
    }

    FragColor = float4(color, 1.0);
}

technique _021_circle_of_lights
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
