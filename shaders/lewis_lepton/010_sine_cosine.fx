
uniform float u_time < source = "timer"; >;

void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

float circleshape(float2 position, float radius)
{
    return step(radius, length(position - 0.5));
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float u_time_ps = u_time / min(BUFFER_WIDTH, BUFFER_HEIGHT);
    float2 coord = TexCoord;
    float3 color = 0.0;

    float2 translate = float2(sin(u_time_ps), cos(u_time_ps));
    coord += translate * 0.5;

    color += circleshape(coord, 0.3);

    FragColor = float4(color, 1.0);
}

technique _010_sine_cosine
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
