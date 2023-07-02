document.addEventListener('DOMContentLoaded', function(){
  let modalButton = document.getElementById('modal-button');
  modalButton.addEventListener('click', function(){
    let modal = document.getElementById('modal');
    let disclaimer = document.getElementById('disclaimer');
    let specialAnswerForm = document.getElementById('modal-form');
    modal.style.display = 'block';
    disclaimer.style.display = 'block';
    specialAnswerForm.style.display = 'none';
  });

  let disagreeButton = document.getElementById('disagree-button');
  disagreeButton.addEventListener('click', function(){
    let modal = document.getElementById('modal');
    modal.style.display = 'none';
  });

  let agreeButton = document.getElementById('agree-button');
  agreeButton.addEventListener('click', function(){
    let disclaimer = document.getElementById('disclaimer');
    let specialAnswerForm = document.getElementById('modal-form');
    disclaimer.style.display = 'none';
    specialAnswerForm.style.display = 'block';
  });
  
  // ページが読み込まれたときに実行する関数を定義
  $(document).ready(function() {
    // "modal-button"がクリックされたときの処理
    $('#modal-button').click(function() {
      // ポップアップを表示
      $('#modal').show();
    });

    // "disagree-button"がクリックされたときの処理
    $('#disagree-button').click(function() {
      // ポップアップを非表示
      $('#modal').hide();
    });
  });

});