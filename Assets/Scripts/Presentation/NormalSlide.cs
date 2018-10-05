using UnityEngine;

namespace Presentation
{
	[CreateAssetMenu(fileName = "New Slide", menuName = "Presentation/NormalSlide")]
	public class NormalSlide : ScriptableObject
	{
		public string[] _slideTexts;
	}
}
