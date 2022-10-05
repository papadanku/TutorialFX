
uniform float u_time < source = "timer"; >;

void MainVS(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

float random2d(float2 coord)
{
    return frac(sin(dot(coord.xy, float2(12.9898, 78.233))) * 43758.5453);
}

void MainPS(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 u_resolution = float2(BUFFER_WIDTH, BUFFER_HEIGHT);
    float u_time_ps = u_time / min(u_resolution.x, u_resolution.y);

    float2 coord = (TexCoord * u_resolution) * 0.01;
    coord -= u_time_ps + float2(sin(coord.y), cos(coord.x));

    float rand01 = frac(random2d(floor(coord)) + u_time_ps / 60.0);
    float rand02 = frac(random2d(floor(coord)) + u_time_ps / 40.0);

    rand01 *= 0.4 - length(frac(coord));

    FragColor = float4(rand01 * 4.0, rand02 * rand01 * 4.0, 0.0, 1.0);
}

technique _023_morph_grid
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
