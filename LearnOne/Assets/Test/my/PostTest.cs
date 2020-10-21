using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PostTest : MonoBehaviour
{


    [Range(0,0.5f)] public float _WaveWidth = 0.3f;


    private Shader purecolorShader;

    private void Awake()
    {
        purecolorShader = Shader.Find("Hidden/GreyPost");

    }


    [ImageEffectOpaque]
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {

        Material mt = new Material(purecolorShader);
        mt.SetFloat("_WaveWidth", _WaveWidth);

        Graphics.Blit(source, destination, mt);

    }

}
