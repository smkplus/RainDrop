using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ImageEffect : MonoBehaviour {
public Material mat;
private void OnRenderImage(RenderTexture src, RenderTexture dest) {
	Graphics.Blit(src,dest,mat);
}
}
