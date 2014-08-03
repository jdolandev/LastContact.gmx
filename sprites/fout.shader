float3 vec3(float4 x0)
{
    return float3(x0.xyz);
}
// Varyings
static float4 _v_vColour = {0, 0, 0, 0};
static float2 _v_vTexcoord = {0, 0};

static float4 gl_Color[1] =
{
    float4(0, 0, 0, 0)
};


uniform float _gm_AlphaRefValue : register(c3);
uniform bool _gm_AlphaTestEnabled : register(c4);
uniform sampler2D _gm_BaseTexture : register(s0);
uniform float4 _gm_FogColour : register(c5);
uniform bool _gm_PS_FogEnabled : register(c6);
uniform float4 _shades[4] : register(c7);

float4 gl_texture2D(sampler2D s, float2 t)
{
    return tex2D(s, t);
}

#define GL_USES_FRAG_COLOR
;
;
;
;
;
void _DoAlphaTest(in float4 _SrcColour)
{
{
if(_gm_AlphaTestEnabled)
{
{
if((_SrcColour.w <= _gm_AlphaRefValue))
{
{
discard;
;
}
;
}
;
}
;
}
;
}
}
;
void _DoFog(inout float4 _SrcColour, in float _fogval)
{
{
if(_gm_PS_FogEnabled)
{
{
(_SrcColour = lerp(_SrcColour, _gm_FogColour, clamp(_fogval, 0.0, 1.0)));
}
;
}
;
}
}
;
;
;
;
void gl_main()
{
{
float4 _vColor = (_v_vColour * gl_texture2D(_gm_BaseTexture, _v_vTexcoord));
float4 _vLum = float4(0.21259999, 0.71520001, 0.0722, 0.0);
float _lum = dot(_vColor, _vLum);
(gl_Color[0] = _vColor);
if((_lum <= _shades[0].w))
{
(gl_Color[0].xyz = vec3(_shades[0]));
}
else
{
if((_lum <= _shades[1].w))
{
(gl_Color[0].xyz = vec3(_shades[1]));
}
else
{
if((_lum <= _shades[2].w))
{
(gl_Color[0].xyz = vec3(_shades[2]));
}
else
{
(gl_Color[0].xyz = vec3(_shades[3]));
}
;
}
;
}
;
}
}
;
struct PS_INPUT
{
    float4 v0 : TEXCOORD0;
    float2 v1 : TEXCOORD1;
};

struct PS_OUTPUT
{
    float4 gl_Color0 : COLOR0;
};

PS_OUTPUT main(PS_INPUT input)
{
    _v_vColour = input.v0;
    _v_vTexcoord = input.v1.xy;

    gl_main();

    PS_OUTPUT output;
    output.gl_Color0 = gl_Color[0];

    return output;
}
