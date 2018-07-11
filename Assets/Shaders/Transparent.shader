Shader "Custom/Transparet" {
	Properties {
        _Color("Color", Color) = (1,1,1,1)
		_MainTex ("MainTex", 2D) = "white" {}
	}
	SubShader {

        Tags{
            "Queue" = "Transparent"
        }

        Cull Off

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade
        
        sampler2D _MainTex;
        fixed4 _Color;

        struct Input{
            float2 uv_MainTex;
        };
		
		void surf (Input IN, inout SurfaceOutput o) {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color.rgb;
            o.Alpha  = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}