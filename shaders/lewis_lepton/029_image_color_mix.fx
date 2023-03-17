
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
    float2 coord = TexCoord.xy;
    float3 color = 0.0;

    float4 image = tex2D(u_tex0, coord);
    image.a = length(TexCoord.xy * 2.0 - 1.0);

    color = lerp(image.rgb, color, image.a);

    FragColor = color;
}

technique _029_image_color_mix
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
