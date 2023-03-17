
void VS_Main(in uint ID : SV_VertexID, out float4 Position : SV_Position, out float2 TexCoord : TEXCOORD0)
{
    TexCoord.x = (ID == 2) ? 2.0 : 0.0;
    TexCoord.y = (ID == 1) ? 2.0 : 0.0;
    Position = float4(TexCoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}

static const float PI = 3.1415926535;

float polygonshape(float2 position, float radius, float sides)
{
    // (position * 2.0 - 1.0) scales texture cooordinates from [0.0, 1.0] to [-1.0, 1.0]
    position = position * 2.0 - 1.0;
    float angle = atan2(position.x, position.y);
    float slice = PI * 2.0 / sides;

    return step(radius, cos(floor(0.5 + angle / slice) * slice - angle) * length(position));
}

void PS_Main(in float4 Position : SV_Position, in float2 TexCoord : TEXCOORD0, out float4 FragColor : SV_Target0)
{
    float2 position = TexCoord.xy;

    float3 color = 0.0;

    float polygon = polygonshape(position, 0.6, 6.0);

    color = polygon;

    FragColor = float4(color, 1.0);
}

technique _008_polygon_shape
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
