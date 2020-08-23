// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32688,y:33035,varname:node_3138,prsc:2|emission-9891-RGB,olwid-2010-OUT,olcol-7555-RGB,voffset-6267-OUT;n:type:ShaderForge.SFN_Tex2d,id:9891,x:32292,y:33117,ptovrint:False,ptlb:node_9891,ptin:_node_9891,varname:_node_9891,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:60d24a0b458182244a6000166a66cf59,ntxv:0,isnm:False|UVIN-5030-OUT;n:type:ShaderForge.SFN_NormalVector,id:6311,x:31419,y:32765,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:5531,x:31419,y:32956,varname:node_5531,prsc:2;n:type:ShaderForge.SFN_Dot,id:9709,x:31570,y:32879,varname:node_9709,prsc:2,dt:0|A-6311-OUT,B-5531-OUT;n:type:ShaderForge.SFN_Multiply,id:3858,x:31735,y:32977,varname:node_3858,prsc:2|A-9709-OUT,B-8113-OUT;n:type:ShaderForge.SFN_Vector1,id:8113,x:31554,y:33089,varname:node_8113,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:33,x:31911,y:33073,varname:node_33,prsc:2|A-3858-OUT,B-8113-OUT;n:type:ShaderForge.SFN_Append,id:5030,x:32120,y:33100,varname:node_5030,prsc:2|A-33-OUT,B-6267-OUT;n:type:ShaderForge.SFN_Vector1,id:6267,x:31897,y:33262,varname:node_6267,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Color,id:7555,x:32470,y:33202,ptovrint:False,ptlb:node_7555,ptin:_node_7555,varname:_node_7555,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.1132075,c2:0.1132075,c3:0.1132075,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:2010,x:32470,y:33444,ptovrint:False,ptlb:node_2010,ptin:_node_2010,varname:_node_2010,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;proporder:9891-7555-2010;pass:END;sub:END;*/

Shader "Shader Forge/ToonShader" {
    Properties {
        _node_9891 ("node_9891", 2D) = "white" {}
        _node_7555 ("node_7555", Color) = (0.1132075,0.1132075,0.1132075,1)
        _node_2010 ("node_2010", Float ) = 0.1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_7555)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2010)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                float node_6267 = 0.1;
                v.vertex.xyz += float3(node_6267,node_6267,node_6267);
                float _node_2010_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2010 );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_node_2010_var,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _node_7555_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7555 );
                return fixed4(_node_7555_var.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_9891; uniform float4 _node_9891_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float node_6267 = 0.1;
                v.vertex.xyz += float3(node_6267,node_6267,node_6267);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_8113 = 0.5;
                float node_6267 = 0.1;
                float2 node_5030 = float2(((dot(i.normalDir,lightDirection)*node_8113)+node_8113),node_6267);
                float4 _node_9891_var = tex2D(_node_9891,TRANSFORM_TEX(node_5030, _node_9891));
                float3 emissive = _node_9891_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_9891; uniform float4 _node_9891_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float node_6267 = 0.1;
                v.vertex.xyz += float3(node_6267,node_6267,node_6267);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                float node_6267 = 0.1;
                v.vertex.xyz += float3(node_6267,node_6267,node_6267);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
