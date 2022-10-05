
uniform float u_time < source = "timer"; >;

void MainVS(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void MainPS(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float u_time_ps = u_time / min(BUFFER_WIDTH, BUFFER_HEIGHT);
    float2 coord = TexCoord.xy;
    float color = 0.0;

    color += sin(coord.x * 50.0 + cos(u_time_ps + coord.y * 10.0 + sin(coord.x * 50.0 + u_time_ps * 2.0))) * 2.0;
    color += cos(coord.x * 20.0 + sin(u_time_ps + coord.y * 10.0 + cos(coord.x * 50.0 + u_time_ps * 2.0))) * 2.0;
    color += sin(coord.x * 30.0 + cos(u_time_ps + coord.y * 10.0 + sin(coord.x * 50.0 + u_time_ps * 2.0))) * 2.0;
    color += cos(coord.x * 10.0 + sin(u_time_ps + coord.y * 10.0 + cos(coord.x * 50.0 + u_time_ps * 2.0))) * 2.0;


    FragColor = float4(float3(color + coord.y, color + coord.x, color), 1.0);
}

technique _016_warp_lines
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
