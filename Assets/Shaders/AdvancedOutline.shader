Shader "Custom/AdvancedOutline" 
{

Properties 
{
  _Color ("Color", Color) = (1,1,1,1)
  _RampTex ("RampTex", 2D) = "white" {}
  _Outline ("Outline Widht", Range(0.0,1.0)) = 0.0
  _OutlineColor ("Outline Color", Color) = (1,1,1,1)
}

SubShader 
{

Tags 
{ 
  "RenderType"="Opaque" 
}

Cull Off

CGPROGRAM
#pragma surface surf ToonRamp

float4 _Color;
sampler2D _RampTex;

float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
{
  float diff = dot(s.Normal, lightDir);
  float h = diff * 0.5 + 0.5;
  float2 rh = h;
  float3 ramp = tex2D(_RampTex, rh).rgb;

  float4 c;
  c.rgb = s.Albedo * _LightColor0.rgb * ramp;
  c.a = s.Alpha;

  return c;
}

struct Input
{
  float2 uv_MainTex;
};

void surf (Input IN, inout SurfaceOutput o) 
{
  o.Albedo = _Color.rgb;
}
ENDCG

// Outline
// Vertex fragment, need a pass
Pass
{
    // Culling the front, only show backfaces
    Cull Front

CGPROGRAM
    #pragma vertex vert
    #pragma fragment frag

    #include "UnityCG.cginc"

    struct appdata{
        float4 vertex : POSITION;
        float3 normal : NORMAL;
    };

    struct v2f{
        float4 pos: SV_POSITION;
        fixed4 color: COLOR;
    };

    float _Outline;
    float4 _OutlineColor;


// the vertex shader
v2f vert(appdata v)
{
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex);

// multiplying the normal with a 3x3 matrix, 
// then normalize it => put it to worldspace
// instead of local space

    float3 norm = normalize( mul((float3x3)UNITY_MATRIX_IT_MV,v.normal));

    float2 offset = TransformViewToProjection(norm.xy);
    
    o.pos.xy += offset * _Outline;
    o.color = _OutlineColor;
    return o;
}


// the fragment shader
fixed4 frag(v2f i) : SV_Target
{
    return i.color;
}


ENDCG            
    }
  }
  FallBack "Diffuse"
}