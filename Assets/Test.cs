using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour {
	public GameObject Target;

	// Use this for initialization
	void Start () {
	StartCoroutine(Delay());
	}
	
IEnumerator Delay(){
	yield return new WaitForSeconds(1);
	Target.SetActive(true);
}
}
