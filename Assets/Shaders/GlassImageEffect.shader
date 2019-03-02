Shader "Hidden/GlassImageEffect"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Distortion("Distortion",2D) = "white"{}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

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
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex,_Distortion;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 distortion = tex2D(_Distortion,i.uv);
				fixed4 col = tex2D(_MainTex, i.uv+distortion.r/10);
				
	
				return distortion;
			}
			ENDCG
		}
	}
}
