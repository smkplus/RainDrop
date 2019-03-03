Shader "Smkgames/BrokenGlass3D"
{
    Properties{
        _MainTex("MainTex",2D) = "white"{}
        _Alpha("Alpha",Float) = 1
    }
    SubShader
    {
Tags {"Queue"="Transparent" "RenderType"="Transparent"}
 Blend SrcAlpha OneMinusSrcAlpha 


        GrabPass
        {
            "_GrabTexture"
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
                float2 grabPos : TEXCOORD1;
                float3 normal :NORMAL;
            };

            struct v2f
            {
				float2 uv : TEXCOORD0;
                float4 grabPos : TEXCOORD1;
                half3 worldNormal :TEXCOORD2;
                float4 vertex : SV_POSITION;

            };
            sampler2D _MainTex;
            float _Intensity,_Alpha;

            v2f vert (appdata v)
            {
                v2f o;
				o.uv = v.uv;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.grabPos = ComputeGrabScreenPos(o.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            sampler2D _GrabTexture;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 c = 0;
                //c.rgb = i.worldNormal*0.5+0.5;
                float3 distortion = UnpackNormal(tex2D(_MainTex,i.uv));
                fixed4 col = tex2Dproj(_GrabTexture, i.grabPos+float4(distortion,0));
                return col;
            }
            ENDCG
        }
    }
}