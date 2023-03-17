
uniform float u_time < source = "timer"; >;
static const int AMOUNT = 2;

void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float u_time_ps = u_time / min(BUFFER_WIDTH, BUFFER_HEIGHT);
    float2 u_resolution = float2(BUFFER_WIDTH, BUFFER_HEIGHT);
    float2 FragCoord = TexCoord.xy * u_resolution;

    float2 coord = 20.0 * (FragCoord - u_resolution / 2.0) / min(u_resolution.y, u_resolution.x);

    float len;

    for(int i = 0; i < AMOUNT; i++)
    {
        len = length(coord);

        coord.x = coord.x - cos(coord.y + sin(len)) + cos(u_time_ps / 9.0);
        coord.y = coord.y + sin(coord.x + cos(len)) + sin(u_time_ps / 12.0);
    }

    FragColor = float4(cos(len * 2.0), cos(len * 3.0), cos(len * 1.0), 1.0);
}

technique _015_water_color_2
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
