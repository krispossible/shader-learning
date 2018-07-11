Shader "Custom/HologramWall"{
    Properties{

        _MainTex ("Diffuse", 2D) = "white" {}

        _StencilRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOperation("Stencil Oper", Float) = 2

        _ColorMask("ColorMask", Float) = 0
    }

    SubShader{
        Tags{"Queue" = "Geometry"}

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
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input{
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o){
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }

    FallBack "Diffuse"
}