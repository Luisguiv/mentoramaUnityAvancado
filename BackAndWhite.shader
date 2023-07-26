Shader "Unlit/BlackAndWhite"
{
    Properties
    {
        _MainTex("Minha Textura", 2D) = "white" {}
        _GreyIntensity("Fator Cinza", Range(0, 1)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque"}
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct VertexOutput
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _GreyIntensity;

            VertexOutput vert (MeshData v)
            {
                VertexOutput o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 frag (VertexOutput input) : SV_Target
            {
                float4 cor = tex2D(_MainTex, input.uv);
                float lum = cor.r * 0.3 + cor.g + 0.59 + cor.b * 0.11;

                return lerp(cor, lum*0.4, _GreyIntensity);
            }
            ENDCG
        }
    }
}
