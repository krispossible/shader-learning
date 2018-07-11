// This language is: Unity Shaderlab 
// CG/HLSL: High Level Shader Lanugage 

// Shader placement 
Shader "Custom/MyShader" {

// Properties
	Properties {
		_AlbedoColor ("Albedo Color", Color) = (1,1,1,1)
		_Texture ("Texture", 2D) = "white" {}
		_Normal ("Normal map",2D) = "bump" {}
		_NSlider ("Normal amount", Range(-1,2)) = 1
	}

// Processing
	SubShader {

		CGPROGRAM
		// pragma: precomipler, defines we use surface shader. main function (surf), type of light (Lambert)
		#pragma surface surf Lambert
		
		// inputs required
		struct Input{ 
			// Main Texture UV
			float2 uv_Texture;
			float2 uv_Normal;
			
			// Change shader values relative to the camera angle
			float viewDir;
		};

		// proprety references, must use same name
		fixed4 _AlbedoColor;
		sampler2D _Texture;
		sampler2D _Normal;
		half _NSlider;
		

		// shader function with input and output
		void surf (Input IN, inout SurfaceOutput o){
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb + _AlbedoColor.rgb;
			o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_Normal));
			o.Normal*= float3(_NSlider, _NSlider, 1);
		}

		ENDCG
	}

// Fallback if the GPU can't handle it
	FallBack "Diffuse"
}
