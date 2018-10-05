using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GaussianBlur : MonoBehaviour
{
    [SerializeField] private Material _blurMaterial;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        // Copy the source Render Texture to the destination,
        // applying the material along the way.
        Graphics.Blit(src, dest, _blurMaterial);
    }
}