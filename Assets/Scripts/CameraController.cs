using UnityEngine;

public class CameraController : MonoBehaviour
{
	[SerializeField] private float _speed;

	private void Update()
	{
		var horizontal = Input.GetAxis("Horizontal");
		var vertical = Input.GetAxis("Vertical");

		transform.position = Vector3.MoveTowards(transform.position,
			transform.position + new Vector3(horizontal, 0, vertical), Time.deltaTime * _speed);
	}
}