
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
    float color = 1.0;

    float size = 12.0;

    float alpha = sin(floor(coord.x * size) + u_time_ps * 4.0) + 1.0 / 2.0;

    // Alpha is not displayable when written to backbuffer
    // So we multiply the color by its alpha to emulate it
    FragColor = color * alpha;
}

technique _019_scanning_lines
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
