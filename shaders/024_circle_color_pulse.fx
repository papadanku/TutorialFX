
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
    float3 color = 0.0;

    float2 translate = -0.5;
    coord += translate;

    color.r = abs(0.1 + length(coord) - 0.6 * abs(sin(u_time_ps * 0.9 / 12.0)));
    color.g = abs(0.1 + length(coord) - 0.6 * abs(sin(u_time_ps * 0.6 / 4.0)));
    color.b = abs(0.1 + length(coord) - 0.6 * abs(sin(u_time_ps * 0.3 / 9.0)));

    FragColor = float4(0.1 / color, 1.0);
}

technique _024_circle_color_pulse
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
