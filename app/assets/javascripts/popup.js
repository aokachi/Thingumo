document.addEventListener('DOMContentLoaded', function(){
  let popupButton = document.getElementById('popup-button');
  popupButton.addEventListener('click', function(){
    let popup = document.getElementById('popup');
    let disclaimer = document.getElementById('disclaimer');
    let specialAnswerForm = document.getElementById('special-answer-form');
    popup.style.display = 'block';
    disclaimer.style.display = 'block';
    specialAnswerForm.style.display = 'none';
  });

  let disagreeButton = document.getElementById('disagree-button');
  disagreeButton.addEventListener('click', function(){
    let popup = document.getElementById('popup');
    popup.style.display = 'none';
  });

  let agreeButton = document.getElementById('agree-button');
  agreeButton.addEventListener('click', function(){
    let disclaimer = document.getElementById('disclaimer');
    let specialAnswerForm = document.getElementById('special-answer-form');
    disclaimer.style.display = 'none';
    specialAnswerForm.style.display = 'block';
  });
  
  // ページが読み込まれたときに実行する関数を定義
  $(document).ready(function() {
    // "popup-button"がクリックされたときの処理
    $('#popup-button').click(function() {
      // ポップアップを表示
      $('#popup').show();
    });

    // "disagree-button"がクリックされたときの処理
    $('#disagree-button').click(function() {
      // ポップアップを非表示
      $('#popup').hide();
    });
  });

});