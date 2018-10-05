using UnityEngine;
using UnityEngine.UI;

namespace Presentation
{
	public class CatSelector : MonoBehaviour
	{
		[Header("Navigation")] 
		[SerializeField] private Button _nextButton; 
		[SerializeField] private Button _previousButton; 
		[Header("UI")] 
		[SerializeField] private Text _slideTitle; 
		[SerializeField] private Text _slideCounter; 
		[SerializeField] private Text _slideContent;
		[SerializeField] private CatSlide[] _catSlideObjects; 
		[Header("Rendering")] 
		[SerializeField] private SkinnedMeshRenderer _catRenderer; 
		[SerializeField] private RectTransform _contentContainer; 
		private int _i;

		private void OnEnable()
		{
			_nextButton.onClick.AddListener(Next);
			_previousButton.onClick.AddListener(Previous);
		}

		private void OnDisable()
		{
			_nextButton.onClick.RemoveListener(Next);
			_previousButton.onClick.RemoveListener(Previous);
		}

		private void Start()
		{
			SetValues();
		}

		private void Update()
		{
			if (Input.GetKeyDown(KeyCode.LeftArrow))
			{
				Previous();
			}
			
			if (Input.GetKeyDown(KeyCode.RightArrow))
			{
				Next();
			}
		}

		private void Next()
		{
			if (_i < _catSlideObjects.Length - 1)
			{
				_i++;
			}
			else
			{
				_i = 0;
			}

			SetValues();
		}

		private void Previous()
		{
			if (_i > 0)
			{
				_i--;
			}
			else
			{
				_i = _catSlideObjects.Length - 1;
			}

			SetValues();
		}

		private void SetValues()
		{
			var currentObject = _catSlideObjects[_i];

			currentObject.GetText();

			_contentContainer.sizeDelta = new Vector2(1000, currentObject.lineHeight);
			_slideTitle.text = currentObject.material.name;
			_slideCounter.text = _i + 1 + "/" + (_catSlideObjects.Length).ToString();
			_slideContent.text = currentObject.slideText;
			_catRenderer.material = currentObject.material;
		}
	}
}