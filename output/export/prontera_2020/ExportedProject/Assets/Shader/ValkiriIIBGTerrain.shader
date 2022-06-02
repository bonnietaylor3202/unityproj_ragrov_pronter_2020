Shader "ValkiriII/BG/Terrain" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RChannel ("RChannel", 2D) = "black" {}
		_GChannel ("GChannel", 2D) = "black" {}
		_BChannel ("BChannel", 2D) = "black" {}
		_AChannel ("AChannel", 2D) = "black" {}
		_BlendMap ("Blend Texture", 2D) = "black" {}
	}
	SubShader {
		LOD 200
		Tags { "RenderType" = "Opaque" }
		0 {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 24145
			Program "vp" {
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = 0.0;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2 = (-u_xlat5.x) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_2 + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = 0.0;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2 = (-u_xlat5.x) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_2 + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = 0.0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					float u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb0 = vs_TEXCOORD5.z<u_xlat0;
					    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0 = max(u_xlat0, _LightShadowData.x);
					    u_xlat16_18 = u_xlat0 + u_xlat0;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.w = 0.0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					float u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat0 = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb0 = vs_TEXCOORD5.z<u_xlat0;
					    u_xlat0 = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0 = max(u_xlat0, _LightShadowData.x);
					    u_xlat16_18 = u_xlat0 + u_xlat0;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat16_3.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat5.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    u_xlat3 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2 = (-u_xlat5.x) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_2 + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec4 u_xlat16_4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.w = 0.0;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_4 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_3.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2 = (-u_xlat5.x) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_2 + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.w = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.w = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.w = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.w = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat16_3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb0 = vs_TEXCOORD5.z<u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
					    u_xlat16_18 = u_xlat0.x + u_xlat0.x;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp vec4 in_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					uniform mediump sampler2D unity_Lightmap;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					bool u_xlatb0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat0.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb0 = vs_TEXCOORD5.z<u_xlat0.x;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat0.x = max(u_xlat0.x, _LightShadowData.x);
					    u_xlat16_18 = u_xlat0.x + u_xlat0.x;
					    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat16_3.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat5.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz + u_xlat10_2.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    u_xlat3 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec4 in_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD1;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					varying highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec4 u_xlat16_4;
					vec4 u_xlat5;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD2.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_4 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
					    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
					    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat16_3.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat2.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat2.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat2.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat2 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat2);
					    u_xlat2 = u_xlat2 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat2 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat2 * u_xlat1;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BlendMap;
					uniform lowp sampler2D _RChannel;
					uniform lowp sampler2D _GChannel;
					uniform lowp sampler2D _BChannel;
					uniform lowp sampler2D _AChannel;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec4 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec4 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					bool u_xlatb5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat5.x = texture2D(_ShadowMapTexture, vs_TEXCOORD5.xy).x;
					    u_xlatb5 = vs_TEXCOORD5.z<u_xlat5.x;
					    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
					    u_xlat5.x = max(u_xlat5.x, _LightShadowData.x);
					    u_xlat16_2.x = (-u_xlat5.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + u_xlat5.x;
					    u_xlat10_0.xyz = texture2D(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat10_1.xyz + (-u_xlat10_3.xyz);
					    u_xlat10_1 = texture2D(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat10_1.xxx * u_xlat16_7.xyz + u_xlat10_3.xyz;
					    u_xlat16_4.xyz = u_xlat10_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat10_0.xyz = texture2D(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat10_1.w) + 1.0;
					    u_xlat10_0.xyz = texture2D(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat10_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD2.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat5.x * u_xlat16_2 + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_7.x + u_xlat16_2;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat5.x * u_xlat16_2 + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_7.x + u_xlat16_2;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					UNITY_LOCATION(7) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(8) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_18 = u_xlat0 * u_xlat16_18 + _LightShadowData.x;
					    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					UNITY_LOCATION(7) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(8) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_18 = u_xlat0 * u_xlat16_18 + _LightShadowData.x;
					    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat16_3.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat5.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat5.x * u_xlat16_2 + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_7.x + u_xlat16_2;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat16_3.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat5.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat5.x * u_xlat16_2 + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2) + 1.0;
					    u_xlat16_2 = u_xlat0.x * u_xlat16_7.x + u_xlat16_2;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_7.xyz;
					    SV_Target0.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7.x + u_xlat16_2.x;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7.x + u_xlat16_2.x;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					UNITY_LOCATION(7) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(8) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_18 = u_xlat0.x * u_xlat16_18 + _LightShadowData.x;
					    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _LightShadowData;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform mediump sampler2D unity_Lightmap;
					UNITY_LOCATION(7) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(8) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD3;
					in highp vec4 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    vec3 txVec0 = vec3(vs_TEXCOORD5.xy,vs_TEXCOORD5.z);
					    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_18 = u_xlat0.x * u_xlat16_18 + _LightShadowData.x;
					    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
					    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_4.xyz = min(vec3(u_xlat16_18), u_xlat16_4.xyz);
					    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat16_3.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat5.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_18 = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_0.xyz;
					    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_4.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD3.xyz + u_xlat16_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7.x + u_xlat16_2.x;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BlendMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp float vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec4 vs_TEXCOORD5;
					out highp vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BlendMap_ST.xy + _BlendMap_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
					    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
					    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
					    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
					    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
					    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat16_3.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat3 = u_xlat1.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
					    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat5.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					#ifdef GL_EXT_shader_texture_lod
					#extension GL_EXT_shader_texture_lod : enable
					#endif
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	mediump vec4 unity_FogColor;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					UNITY_LOCATION(1) uniform mediump sampler2D _BlendMap;
					UNITY_LOCATION(2) uniform mediump sampler2D _RChannel;
					UNITY_LOCATION(3) uniform mediump sampler2D _GChannel;
					UNITY_LOCATION(4) uniform mediump sampler2D _BChannel;
					UNITY_LOCATION(5) uniform mediump sampler2D _AChannel;
					UNITY_LOCATION(6) uniform highp sampler2D _ShadowMapTexture;
					UNITY_LOCATION(7) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec3 vs_TEXCOORD2;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					mediump vec3 u_xlat16_7;
					mediump vec3 u_xlat16_9;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat5.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
					    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat5.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat16_2.x = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2.x = u_xlat5.x * u_xlat16_2.x + _LightShadowData.x;
					    u_xlat16_7.x = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_7.x + u_xlat16_2.x;
					    u_xlat16_0.xyz = texture(_GChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = texture(_RChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_7.xyz = u_xlat16_1.xyz + (-u_xlat16_3.xyz);
					    u_xlat16_1 = texture(_BlendMap, vs_TEXCOORD0.zw);
					    u_xlat16_7.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat16_3.xyz;
					    u_xlat16_4.xyz = u_xlat16_0.xyz + (-u_xlat16_7.xyz);
					    u_xlat16_7.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_0.xyz = texture(_BChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_4.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.x = (-u_xlat16_1.w) + 1.0;
					    u_xlat16_0.xyz = texture(_AChannel, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + u_xlat16_0.xyz;
					    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
					    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
					    u_xlat16_2.xyz = u_xlat16_7.xyz * vs_TEXCOORD3.xyz + u_xlat16_4.xyz;
					    u_xlat0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
					#else
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
		}
	}
	Fallback "VertexLit"
}