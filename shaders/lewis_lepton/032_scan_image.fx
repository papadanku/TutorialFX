
uniform float u_time < source = "timer"; >;

uniform float2 u_mouse < source = "mousepoint"; >;

static const float size = 6.0;

static const float speed = -10.0;

static const bool flip = true;

texture2D backbuffer : COLOR;

sampler2D u_tex0
{
    Texture = backbuffer;
    #if BUFFER_COLOR_BIT_DEPTH == 8
        SRGBTexture = TRUE;
    #endif
};

void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 u_resolution = float2(BUFFER_WIDTH, BUFFER_HEIGHT);
    float u_time_ps = u_time / min(u_resolution.x, u_resolution.y);

    float2 coord = TexCoord;
    float3 color = 0.0;

    float4 image = tex2D(u_tex0, coord);

    if (flip)
    {
        image.a = sin(floor(coord.x * size) - u_time_ps * speed);
    }
    else
    {
        image.a = sin(floor(coord.y * size) - u_time_ps * speed);
    }

    FragColor = image * image.a;
}

technique _032_scan_image
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
