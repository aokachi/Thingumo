document.addEventListener('DOMContentLoaded', function(){
  let modalButton = document.getElementById('modal-button');
  let modal = document.getElementById('modal');
  let modalInner = document.getElementById('modal-inner');
  let modalForm = document.getElementById('modal-form');
  let disagreeButton = document.getElementById('disagree-button');
  let agreeButton = document.getElementById('agree-button');
  let cancelButton = document.getElementById('cancel-button');
  
  modal.style.display = 'none';
  
  modalButton.addEventListener('click', function(){
    modal.style.display = 'flex';
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
    modalInner.style.display = 'block'; // この行を追加して、キャンセルボタンを押したときにmodalInnerを再表示します
    modalForm.style.display = 'none'; // この行を追加して、キャンセルボタンを押したときにmodalFormを非表示にします
  });
});
