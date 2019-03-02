 Shader "Example/Normal Extrusion" {
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _Roughness("Roughness",2D) = "white"{}
      _Metallic("Metallic", Range(0,1)) = 0.5
      _Smoothness ("Smoothness", Range(0,1)) = 0.5
      _NormalMap("NormalMap",2D) = "bump"{}
      _Noise("Noise",2D) = "white"{}
	  _GroundTex("GroundTex", 2D) = "white" {}
	  _DispTex("DispTex", 2D) = "white" {}
      _Amount ("Extrusion Amount", Float) = 0.5
       _Speed("Speed",float) = 1
        _Direction("Direction",Vector) = (0,0.2,0,0)
    }
    SubShader {
Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" "DisableBatching"="True" }
            LOD 200
      CGPROGRAM
        #pragma surface surf Standard vertex:vert addshadow
 
        #pragma target 3.0 
      struct Input {
          float2 uv_MainTex;
      };
      float _Amount,_Metallic,_Smoothness,_Speed;
      float4 _Direction;
      sampler2D _MainTex,_GroundTex,_DispTex,_Roughness,_NormalMap,_Noise;
      void vert (inout appdata_full v) {
          float4 disp = tex2Dlod (_DispTex, v.texcoord);
          float4 tex = tex2Dlod(_Noise, float4(v.texcoord.xy + (_Time.y * _Speed), 0, 0));
          // v.vertex.xyz += disp.r * tex.y *  _Direction.xyz * _Speed*_Amount/10;
          // v.vertex.xyz += v.normal *disp.g*_Amount/10 * _Speed;
      }
  	  void surf(Input IN, inout SurfaceOutputStandard o) {
		  float3 maintex = tex2D (_MainTex, IN.uv_MainTex).rgb;
		  float3 ground = tex2D (_GroundTex, IN.uv_MainTex+_Time.x).rgb;
		  float3 disp = tex2D (_DispTex, IN.uv_MainTex).rgb;
      float3 dispGrayscale = float3(disp.r,disp.r,disp.r);
		  float3 mainLayer =  maintex* (1-dispGrayscale);
		  float3 background =  ground*dispGrayscale;

		float3 result = max(background,mainLayer);

         // o.Albedo = lerp(result,maintex,dispGrayscale);
          o.Albedo = result;
          //o.Metallic = _Metallic;
          //o.Smoothness = _Smoothness*tex2D(_Roughness,IN.uv_MainTex);
          //o.Normal = UnpackNormal(tex2D(_NormalMap,IN.uv_MainTex));
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }