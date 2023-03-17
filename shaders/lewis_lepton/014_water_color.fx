
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

    for(int n = 1; n < 8; n++)
    {
        float i = float(n);
        coord += float2(0.7 / i + sin(i * coord.y + u_time_ps + 0.3 * i) + 0.8, 0.4 / i * sin(coord.x + u_time_ps + 0.3 * i) + 1.6);
    }

    coord *= float2(0.7 / sin(coord.y + u_time_ps + 0.3) + 0.8, 0.4 / sin(coord.x + u_time_ps + 0.3) + 1.6);

    float3 color = float3(sin(coord.xy) * 0.5 + 0.5, sin(coord.x + coord.y));

    FragColor = float4(color, 1.0);
}

technique _014_water_color
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
