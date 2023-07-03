document.addEventListener('DOMContentLoaded', function(){
  let modalButton = document.getElementById('modal-button');
  let modal = document.getElementById('modal');
  let disclaimer = document.getElementById('disclaimer');
  let specialAnswerForm = document.getElementById('modal-form');
  let disagreeButton = document.getElementById('disagree-button');
  let agreeButton = document.getElementById('agree-button');

  modalButton.addEventListener('click', function(){
    modal.style.display = 'block';
    disclaimer.style.display = 'block';
    specialAnswerForm.style.display = 'none';
  });

  disagreeButton.addEventListener('click', function(){
    modal.style.display = 'none';
  });

  agreeButton.addEventListener('click', function(){
    disclaimer.style.display = 'none';
    specialAnswerForm.style.display = 'block';
  });

  $(document).ready(function() {
    $('#modal-button').click(function() {
      $('#modal').show();
    });

    $('#disagree-button').click(function() {
      $('#modal').hide();
    });
  });
});
