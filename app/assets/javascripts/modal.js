document.addEventListener('DOMContentLoaded', function(){
  let modalButton = document.getElementById('modal-button');
  let modal = document.getElementById('modal');
  let modalInner = document.getElementById('modal-inner');
  let modalForm = document.getElementById('modal-form');
  let disagreeButton = document.getElementById('disagree-button');
  let agreeButton = document.getElementById('agree-button');
  let cancelButton = document.getElementById('cancel-button');
  
  modal.style.display = 'none'; // ページが読み込まれた時にモーダルを非表示にする
  
  modalButton.addEventListener('click', function(){
    modal.style.display = 'flex';
    modal.style.marginTop = window.innerHeight / 4 + 'px'; // モーダルを垂直方向に再配置
    modalInner.style.display = 'block';
    modalForm.style.display = 'none';
  });
  
  disagreeButton.addEventListener('click', function(){
    modal.style.display = 'none';
  });
  
  agreeButton.addEventListener('click', function(){
    modalInner.style.display = 'none';
    modalForm.style.display = 'block';
  });
  
  cancelButton.addEventListener('click', function(){
    modal.style.display = 'none';
  });
});
