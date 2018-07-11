Shader "Custom/OceanWeaves" {
	Properties {
		_Tint ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Freq("Frequency", Range(0,5)) = 3
        _Speed("Speed", Range(0,100)) = 10
        _Amp("Amplitude", Range(0,1)) = 0.5
	}
	SubShader {

        Cull Off

		CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        struct Input{
            float2 uv_MainTex;
            float3 vertColor;
        };

        float4 _Tint;
        float _Freq;
        float _Speed;
        float _Amp;
        sampler2D _MainTex;

        struct appdata{
            float3 normal: NORMAL;
            float4 vertex: POSITION;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };

        void vert(inout appdata v, out Input o){
            UNITY_INITIALIZE_OUTPUT(Input, o);
            // _Time is Unity created
            float t = _Time * _Speed;
            float waveHeight = sin(t+v.vertex * _Freq) * _Amp;
            v.vertex.y += waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            // vertex color is based on the wave height
            o.vertColor = waveHeight + 2;
        }

       void surf(Input IN, inout SurfaceOutput o){
        float4 c = tex2D(_MainTex, IN.uv_MainTex);
        o.Albedo = c * IN.vertColor.rgb;
       }
		
		ENDCG
	}
	FallBack "Diffuse"
}