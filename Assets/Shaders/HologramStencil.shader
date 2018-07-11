Shader "Custom/HologramStencil" {
	Properties {
		_RimColor ("Rim Color", Color) = (0.0,0.5,0.5,0.0)
        _RimPower ("Rim Power", Range(0.5,8.0)) = 3.0

        _StencilRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOperation("Stencil Oper", Float) = 2

        _ColorMask("ColorMask", Float) = 0
	}
	SubShader {
        Tags{"Queue" = "Geometry-1"}

        Cull Off

         Stencil{
            Ref [_StencilRef]
            Comp [_StencilComp]
            Pass [_StencilOperation]
        }

        Pass{
            ZWrite On
            ColorMask [_ColorMask]
        }

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade

        float4 _RimColor;
        float _RimPower;

        struct Input{
            float3 viewDir;
        };
		
		void surf (Input IN, inout SurfaceOutput o) {
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            o.Alpha = pow(rim, _RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}