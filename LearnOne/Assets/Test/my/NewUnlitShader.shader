Shader "Hidden/GreyPost"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WaveWidth ("_WaveWidth",range(0,0.5)) =0.03
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {

            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            float _WaveWidth;
            
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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {

                fixed4 coli = tex2D(_MainTex, i.uv);  
                fixed3 colRGB = coli.rgb;
                
                fixed a = step(coli.a,0);
                fixed3 coliRGB =fixed3(a,a,a);


                float2 center =float2(0.5,0.5);
				float2 distance = center - i.uv;			
                float x = center.x+ center.x*(-distance.x/center.x) *(1-_WaveWidth);
				float y = center.y+ center.y*(-distance.y/center.y) *(1-_WaveWidth);
				float2 uv = float2(x,y);

                float x1 = center.x+ center.x*(-distance.x/center.x) *(2-_WaveWidth);
				float y1 = center.y+ center.y*(-distance.y/center.y) *(2-_WaveWidth);
                float2 uv1 = float2(x1,y1+sqrt(0.0001));
                float2 uv2 = float2(x1,y1-sqrt(0.0001));
                float2 uv3 = float2(x1+0.005,y1);
                float2 uv4 = float2(x1-0.005,y1);
                float2 uv5 = float2(x1+0.005,y1+sqrt(0.0001));
                float2 uv6 = float2(x1-0.005,y1-sqrt(0.0001));
                float2 uv7 = float2(x1+0.005,y1-sqrt(0.0001));
                float2 uv8 = float2(x1-0.005,y1+sqrt(0.0001));

                fixed4 colo = tex2D(_MainTex, uv);
                fixed4 colo1 = tex2D(_MainTex, uv1);
                fixed4 colo2 = tex2D(_MainTex, uv2);
                fixed4 colo3 = tex2D(_MainTex, uv3);
                fixed4 colo4 = tex2D(_MainTex, uv4); 
                fixed4 colo5 = tex2D(_MainTex, uv5);
                fixed4 colo6 = tex2D(_MainTex, uv6);
                fixed4 colo7 = tex2D(_MainTex, uv7);
                fixed4 colo8 = tex2D(_MainTex, uv8); 
                
                fixed3 coloRGB = fixed3(colo.a,colo.a,colo.a);
                fixed3 coloRGB1 = fixed3(colo1.a,colo1.a,colo1.a);
                fixed3 coloRGB2 = fixed3(colo2.a,colo2.a,colo2.a);
                fixed3 coloRGB3 = fixed3(colo3.a,colo3.a,colo3.a);
                fixed3 coloRGB4 = fixed3(colo4.a,colo4.a,colo4.a);
                fixed3 coloRGB5 = fixed3(colo5.a,colo5.a,colo5.a);
                fixed3 coloRGB6 = fixed3(colo6.a,colo6.a,colo6.a);
                fixed3 coloRGB7 = fixed3(colo7.a,colo7.a,colo7.a);
                fixed3 coloRGB8 = fixed3(colo8.a,colo8.a,colo8.a);

                coloRGB = coloRGB +
                coloRGB1   ;

                fixed3 colIO = coliRGB * coloRGB + colRGB;


                fixed3 finishRGB = colIO;

                return fixed4(finishRGB,0);
            }
            
            ENDCG
        }
    }
}
