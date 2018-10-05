Shader "Custom/RimLightShader" 
{

Properties 
{
  _AlbedoColor("AlbedoColor", Color) = (1,1,1,1)
  _Color ("Color", Color) = (1,1,1,1)
  _Power ("Power", Range(0.5, 10.0)) = 3.0
}
	
SubShader 
{

CGPROGRAM
    #pragma surface surf Standard      
    
    struct Input 
    {
        float3 viewDir;
    };
    
    float4 _AlbedoColor;
    float4 _Color;
    float  _Power;
    
void surf (Input IN, inout SurfaceOutputStandard o) 
{

half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));

o.Emission = _Color.rgb * rim > 0.5 ? rim : 0;

}    
ENDCG

}  
	FallBack "Diffuse"
}