Shader "Custom/VFwithLight"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
        // This pass draws the texture with the light on it
        // 1 draw call
		Pass
		{
            // Set Light to Forward Rendering
            // Lights calculated per model basis
            Tags { "LightMode"="ForwardBase" }
            
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            // pragma to receive shadows, disable lightmaps and vertex lights
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
			#include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            // includes to receive shadows
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
                // Normal
                float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
                // Diffuse value, for light color
                fixed4 diff: COLOR0;

				// float4 vertex : SV_POSITION; need to change to pos
                float4 pos : SV_POSITION;

                // to receive shadows, calculates the coords for shadows
                SHADOW_COORDS(1)
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				// o.vertex = UnityObjectToClipPos(v.vertex); need to change to pos
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                // convert the normal on the mesh (local space) to the actual coordinates to the real world
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                // _WorldSpaceLightPos0 comes form the lighting common include
                // dot product is between -1 and 1, but we want the value to be between 0 and 1, so theres the max function
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                // multiply the normal with the light's color
                o.diff = nl * _LightColor0;
                // this function needs the pos, doesnt accept vertex
                TRANSFER_SHADOW(o)
                // return the v2f
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// gets the color from the texture
				fixed4 col = tex2D(_MainTex, i.uv);
                // calculates the shadow values per pixel
                fixed shadow = SHADOW_ATTENUATION(i);
                // if the shadow is zero, the pixel will be 0 = dark
                col *= i.diff * shadow;
				return col;
			}
			ENDCG
		}
        // This pass draws the shadows
        // 1 draw call
        Pass
        {
           Tags {"LightMode"="ShadowCaster"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // tells the compiler that we want to draw shadows
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"

            struct appdata{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv : TEXCOORD0;
            };

            struct v2f{
                V2F_SHADOW_CASTER;
            };

            v2f vert(appdata v){
                // output
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }

            float4 frag(v2f i) : SV_Target{
                SHADOW_CASTER_FRAGMENT(i)
            }
           ENDCG
        }
	}
}
