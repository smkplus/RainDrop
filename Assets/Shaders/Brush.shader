Shader " Sprites/Default "
{ 
Properties
{
_MainTex ("Base (RGB)", 2D) = "white" {}
_Color ("_Color", Color) = (1,1,1,1)
}

SubShader
{
Tags {"Queue"="Transparent" "IgnoreProjector"="true" "RenderType"="Transparent"}
ZWrite Off Blend SrcAlpha OneMinusSrcAlpha Cull Off

Pass
{

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"

struct appdata_t
{
float4 vertex   : POSITION;
float4 color    : COLOR;
float2 texcoord : TEXCOORD0;
};

struct v2f
{
half2 texcoord  : TEXCOORD0;
float4 vertex   : SV_POSITION;
fixed4 color    : COLOR;
};

sampler2D _MainTex,_HeightMap;
fixed4 _Color;
float _Speed;


v2f vert(appdata_t IN)
{
v2f OUT;
OUT.vertex = UnityObjectToClipPos(IN.vertex);
OUT.texcoord = IN.texcoord;
OUT.color = IN.color;
return OUT;
}

float4 frag (v2f i) : COLOR
{

float2 uv = i.texcoord.xy;
    float4 tex = tex2D(_MainTex, uv)*i.color;
return smoothstep(tex,0,0.05)*_Color;
}
ENDCG
}
}
Fallback "Sprites/Default"

}