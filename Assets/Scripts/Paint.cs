using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Paint : MonoBehaviour {
	public static Paint Instance;
	public GameObject Board;
	public GameObject obj;
	public float FadeTime = 10;

	// Use this for initialization
	void Start () {
		Instance = this;
	}
	
	// Update is called once per frame
	void Update () {
		RaycastHit hit;
		Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
		var difference = Board.transform.position - transform.position;
		if(Physics.Raycast(ray,out hit) && Input.GetKey(KeyCode.Mouse0)){
			Vector3 pos = hit.point+difference;
			var Spawn = Instantiate(obj,pos,obj.transform.rotation);
		}
	}
}
