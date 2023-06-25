document.addEventListener('DOMContentLoaded', function(){
  let popupButton = document.getElementById('popup-button');
  popupButton.addEventListener('click', function(){
    let popup = document.getElementById('popup');
    popup.style.display = 'block';
  });

  let disagreeButton = document.getElementById('disagree-button');
  disagreeButton.addEventListener('click', function(){
    let popup = document.getElementById('popup');
    popup.style.display = 'none';
  });

  let agreeButton = document.getElementById('agree-button');
  agreeButton.addEventListener('click', function(){
    window.location.href = '/special_answers/new';
  });
});