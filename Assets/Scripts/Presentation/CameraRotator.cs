using UnityEngine;

namespace Presentation
{
	public class CameraRotator : MonoBehaviour
	{
		[SerializeField] private Vector3 _axis;
		[SerializeField] private float _speed;

		private void Update()
		{
			transform.RotateAround(transform.position, _axis, _speed * Time.deltaTime);
		}
	}
}