﻿Shader "Unlit/NormalMapCode"
{

    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
    }

    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _NormalMap;
            
           
            
            
            
           
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
                float3 tDirWS : TEXCOORD2;
                float3 bDirWS : TEXCOORD3;
               
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0 = v.uv0;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
               
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //准备向量
                i.nDirWS = normalize(i.nDirWS);
                float3 var_NormalMap =UnpackNormal(tex2D(_NormalMap,i.uv0));
                float3x3 TBN = float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 nDirWS2 = normalize(mul(var_NormalMap,TBN)); 
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                //准备点积结果
                float nDotl = dot(nDirWS2,lDir);
                float lambert = max(0.0,nDotl);

                //结果返回
               
                return float4(lambert,lambert,lambert,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
