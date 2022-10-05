
uniform float u_time < source = "timer"; >;

void MainVS(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void MainPS(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 u_resolution = float2(BUFFER_WIDTH, BUFFER_HEIGHT);
    float min_resolution = min(BUFFER_WIDTH, BUFFER_HEIGHT);

    float2 FragCoord = TexCoord.xy * u_resolution;
    float u_time_ps = u_time / min_resolution;

    float2 coord = FragCoord * 1.0 - u_resolution;
    float3 color = 0.0;

    color += abs(cos(coord.x / 20.0) + sin(coord.y / 20.0) - cos(u_time_ps));

    FragColor = float4(color, 1.0);
}

technique _022_morphing_grid_boxes
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
