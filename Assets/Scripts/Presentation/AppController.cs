using System.Collections.Generic;
using System.Runtime.Remoting.Messaging;
using UnityEngine;
using UnityEngine.UI;

namespace Presentation
{
	public class AppController : MonoBehaviour
	{
		[SerializeField] private GameObject _catUI;
		[SerializeField] private GameObject _catGameObject;
		[SerializeField] private GameObject _introUI;
		[SerializeField] private NormalSlide[] _normalSlides;

		[SerializeField] private Button _nextButton;
		[SerializeField] private Button _previousButton;

		[SerializeField] private RectTransform _verticalLayoutGroup;
		[SerializeField] private Text _sampleText;

		private int _outerIterator;
		private int _insideIterator;

		private List<Text> _texts = new List<Text>();

		private void OnEnable()
		{
			_nextButton.onClick.AddListener(NextSlide);
			_previousButton.onClick.AddListener(PreviousSlide);
		}

		private void OnDisable()
		{
			_nextButton.onClick.RemoveListener(NextSlide);
			_previousButton.onClick.RemoveListener(PreviousSlide);
		}

		private void Start()
		{
			_catUI.SetActive(false);
			_catGameObject.SetActive(false);
			_introUI.SetActive(true);
			
			SetValues();
		}

		private void NextSlide()
		{
			if (_insideIterator < _normalSlides[_outerIterator]._slideTexts.Length - 1)
			{
				_insideIterator++;
			}
			else
			{
				_insideIterator = 0;
				
				ClearTexts();

				if (_outerIterator < _normalSlides.Length - 1)
				{
					_outerIterator++;
				}
				else
				{
					ClearTexts();
					
					_catUI.SetActive(true);
					_catGameObject.SetActive(true);
					_introUI.SetActive(false);
				}
			}

			SetValues();
		}

		private void PreviousSlide()
		{
			if (_insideIterator > 0)
			{
				_insideIterator--;
			}
			else
			{
				if (_outerIterator > 0)
				{
					_outerIterator--;
				}
			}
		}

		private void SetValues()
		{
			var currentSlide = _normalSlides[_outerIterator];
			var currentText = Instantiate(_sampleText);

			currentText.rectTransform.SetParent(_verticalLayoutGroup);
			currentText.text = currentSlide._slideTexts[_insideIterator];
			_texts.Add(currentText);
		}

		private void ClearTexts()
		{
			foreach (var t in _texts)
			{
				Destroy(t.gameObject);
			}

			_texts.Clear();
		}

	}
}