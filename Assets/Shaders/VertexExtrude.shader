Shader "Custom/VertexExtrude" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Amount ("Amount", Range(-0.003,0.003)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
        // include the vertex shader at the end
		#pragma surface surf Lambert vertex:vert
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

        // vertex shader inside a surface shader
        // vertex shader program begin
        struct appdata{
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        float _Amount;

        void vert (inout appdata v){
            v.vertex.xyz += v.normal * _Amount;
        }
        // vertex shader program end

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
