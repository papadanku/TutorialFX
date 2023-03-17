
uniform float u_time < source = "timer"; >;

void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 u_resolution = float2(BUFFER_WIDTH, BUFFER_HEIGHT);
    float min_resolution = min(BUFFER_WIDTH, BUFFER_HEIGHT);

    float2 FragCoord = TexCoord.xy * u_resolution;
    float u_time_ps = u_time / min_resolution;

    float2 coord = (FragCoord.xy * 2.0 - u_resolution) / min_resolution;
    coord.x += sin(u_time_ps) + cos(u_time_ps * 2.1);
    coord.y += cos(u_time_ps) + sin(u_time_ps * 1.6);
    float3 color = 0.0;

    color += 0.1 * (abs(sin(u_time_ps)) + 0.1) / length(coord);

    FragColor = float4(color, 1.0);
}

technique _020_moving_light
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
