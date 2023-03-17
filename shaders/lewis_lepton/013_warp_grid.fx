
uniform float u_time < source = "timer"; >;

void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float u_time_ps = u_time / min(BUFFER_WIDTH, BUFFER_HEIGHT);
    float2 coord = TexCoord.xy;
    float3 color = 0.0;

    color += sin(coord.x * cos(u_time_ps / 60.0) * 60.0 + sin(coord.y * cos(u_time_ps / 60.0) * 10.0));
    color += cos(coord.y * sin(u_time_ps / 30.0) * 10.0 + cos(coord.x * sin(u_time_ps / 20.0) * 10.0));

    color *= sin(u_time_ps / 10.0) * 0.5;

    FragColor = float4(color, 1.0);
}

technique _013_warp_grid
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
