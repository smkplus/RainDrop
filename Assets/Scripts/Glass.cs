using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Glass : MonoBehaviour {

public float NormalIntensity = 1;

private void Update() {
	GetComponent<MeshRenderer>().sharedMaterial.SetFloat("_NormalIntensity",NormalIntensity);
}
}
