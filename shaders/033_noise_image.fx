
uniform float u_time < source = "timer"; >;

static const float amount = 0.6;

texture2D backbuffer : COLOR;

sampler2D u_tex0
{
    Texture = backbuffer;
    #if BUFFER_COLOR_BIT_DEPTH == 8
        SRGBTexture = TRUE;
    #endif
};

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

    float2 coord = TexCoord;
    float3 color = 0.0;

    float4 image = tex2D(u_tex0, coord);

    float noise = (random2d(coord) - 0.5) * amount;

    image.r += noise;
    image.g += noise;
    image.b += noise;

    FragColor = image;
}

technique _033_noise_image
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
