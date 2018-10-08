Shader "Custom/BasicVf"
{

Properties
{
   _MainTex ("Texture", 2D) = "white" {}
}

SubShader
{

Tags 
{ 
   "RenderType"="Opaque" 
}

// Shader Level of Detail
// by default its infinite,
// so it gets the max value
// the device can handle
// 
// But you can drop down
// for better performance
// 
// Vertex Lit = 100
LOD 100

// If we use vertex and fragment together, need to put in a pass

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

    sampler2D _MainTex;
    float4 _MainTex_ST;

    // world space, x and z coords
    // runs on every vertex
    
    v2f vert (appdata v)
    {
      v2f o;
      o.vertex = UnityObjectToClipPos(v.vertex);
      o.uv = TRANSFORM_TEX(v.uv, _MainTex);
      return o;
    }

    // screen space, x and y coords
    // runs on every pixel
    
    fixed4 frag (v2f i) : SV_Target
    {
        fixed4 col = tex2D(_MainTex, i.uv);
        return col;
    }
    
ENDCG
    }
  }
}
