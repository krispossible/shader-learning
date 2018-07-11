using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
	[SerializeField] private float _speed;

	void Update()
	{
		float horizontal = Input.GetAxis("Horizontal");
		float vertical = Input.GetAxis("Vertical");

		transform.position = Vector3.MoveTowards(transform.position, transform.position + new Vector3(horizontal, 0, vertical), Time.deltaTime * _speed);
	}
}