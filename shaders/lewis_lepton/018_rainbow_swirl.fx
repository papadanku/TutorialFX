
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

    float angle = atan2(-coord.y + 0.25, coord.x - 0.5) * 0.1;
    float len = length(coord - float2(0.5, 0.25));

    color.r += sin(len * 40.0 + angle * 40.0 + u_time_ps);
    color.g += cos(len * 30.0 + angle * 60.0 - u_time_ps);
    color.b += sin(len * 50.0 + angle * 50.0 + 3.0);

    FragColor = float4(color, 1.0);
}

technique _018_rainbow_swirl
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
