 

Shader "Custom/CustomLightShader" {
	Properties {
        _AlbedoColor("AlbedoColor", Color) = (1,1,1,1)
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf BasicLambert      

        half4 LightingBasicLambert (SurfaceOutput s, half3 lightDir, half atten){
            half NdotL = dot(s.Normal, lightDir);
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            c.a = s.Alpha;
            return c;
        }

		struct Input {
			float2 uv_MainTex;
		};

        float4 _AlbedoColor;

		void surf (Input IN, inout SurfaceOutput o) {
			 o.Albedo = _AlbedoColor.rgb;
		}
        
		ENDCG
	}
	FallBack "Diffuse"
}