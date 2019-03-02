using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fade : MonoBehaviour {
	public MeshRenderer renderer;

	float fillAmount;

		void Start () {
			StartCoroutine(Timer(Paint.Instance.FadeTime));
	}

public IEnumerator Timer(float t)
    {
        float timen = Time.time;
        while (Time.time - timen < t)
        {
            // fillAmount = 1 - ((Time.time - timen) * ((float)1 / t));
			// var col = renderer.material.color;
			// col.r = fillAmount;
			// renderer.material.color = col;
            yield return new WaitForEndOfFrame();
        }
        fillAmount = 0;
    }

}
