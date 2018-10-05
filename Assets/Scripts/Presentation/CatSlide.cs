using UnityEditor;
using UnityEngine;

namespace Presentation
{
	[CreateAssetMenu(fileName = "New Slide", menuName = "Presentation/CatSlide")]
	public class CatSlide : ScriptableObject
	{
		public string slideText;
		public Material material;
		public Shader shader;
		public int lineHeight;

		public void GetText()
		{
			slideText = System.IO.File.ReadAllText(AssetDatabase.GetAssetPath(shader));
		}
	}
}