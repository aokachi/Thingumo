/*カテゴリ用ドロップダウンメニュー*/
$('.question-dropdown').click(function () {
  $(this).attr('tabindex', 1).focus();
  $(this).toggleClass('active');
  $(this).find('.question-dropdown-menu').slideToggle(300);
});
$('.question-dropdown').focusout(function () {
  $(this).removeClass('active');
  $(this).find('.question-dropdown-menu').slideUp(300);
});
$('.question-dropdown .question-dropdown-menu li').click(function () {
  $(this).parents('.question-dropdown').find('span').text($(this).text());
  $(this).parents('.question-dropdown').find('input').attr('value', $(this).attr('id'));
});


$('.question-dropdown-menu li').click(function () {
var input = '<strong>' + $(this).parents('.question-dropdown').find('input').val() + '</strong>',
msg = '<span class="msg">Hidden input value: ';
$('.msg').html(msg + input + '</span>');
}); 


/* ファイルアップロードフォーム */
$(document).ready(function() {
  var currentImageIndex = 0;
  var images = [];

  $('#question_image').on('change', function(event) {
    // 既存の画像配列に新しく選択された画像を追加
    for (var i = 0; i < event.target.files.length; i++) {
      images.push(event.target.files[i]);
    }
    if (images.length > 0) {
      updateThumbnail();
    }
  });

  $('.right-arrow').click(function(event) {
    event.stopPropagation();
    if (currentImageIndex < images.length - 1) {
      currentImageIndex++;
      updateThumbnail();
    }
  });

  $('.left-arrow').click(function(event) {
    event.stopPropagation();
    if (currentImageIndex > 0) {
      currentImageIndex--;
      updateThumbnail();
    }
  });

  function updateThumbnail() {
    if (images.length > 0 && currentImageIndex < images.length) {
      var file = images[currentImageIndex];
      var reader = new FileReader();

      reader.onload = function(event) {
        var img = new Image();
        img.src = event.target.result;

        img.onload = function() {
          var output = $(".image-thumbnails");
          output.empty();
          $('.fa-cloud-upload').hide(); // 画像表示時はアイコンを非表示にする

          var uploadZoneHeight = $('.upload-zone').height();
          var uploadZoneWidth = $('.upload-zone').width();
          var aspectRatio = this.width / this.height;

          var newHeight, newWidth;

          if (uploadZoneHeight * aspectRatio <= uploadZoneWidth) {
            newHeight = uploadZoneHeight;
            newWidth = newHeight * aspectRatio;
          } else {
            newWidth = uploadZoneWidth;
            newHeight = newWidth / aspectRatio;
          }

          var thumbnail = $("<img/>", {
            "src": this.src,
            "class": "img-thumbnail",
            "css": {
              "height": newHeight + "px",
              "width": newWidth + "px"
            }
          });
          output.append(thumbnail);
        };
      };
      reader.readAsDataURL(file);
    } else {
      $('.fa-cloud-upload').show(); // 画像がない場合はアイコンを表示
    }
  }

  // モーダル表示時の処理
  $('#handwrite-image-modal').on('show.bs.modal', function() {
    $('.arrow').addClass('hidden-arrow'); // 矢印を非表示にする
  }).on('hidden.bs.modal', function() {
    $('.arrow').removeClass('hidden-arrow'); // 矢印を再表示する
    // モーダルが閉じるときにpointer-eventsをautoに設定しない
  });

  // ページ離脱時に一時ファイルを削除するようリクエストを送信する
  window.addEventListener('beforeunload', function(event) {
    navigator.sendBeacon('/questions/cleanup_temp_files');
  });  
});

/*===================*/
/* XX - 質問詳細ページ  */
/*===================*/
/* 「これが正解」ボタンを押下した際の非同期リクエスト */
document.addEventListener("DOMContentLoaded", function() {
  const confirmButtons = document.querySelectorAll('.confirm-correct-answer-btn');
  confirmButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      const answerId = this.dataset.answerId;
      const modal = document.getElementById(`correct-answer-confirmation-modal-${answerId}`);
      const confirmBtn = modal.querySelector('.confirm-answer-btn');
      const cancelBtn = modal.querySelector('.cancel-answer-btn');

      modal.style.display = "flex";

      confirmBtn.addEventListener('click', function() {
        fetch(`/questions/${modal.dataset.questionId}/answers/${answerId}/confirm`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
          }
        }).then(response => response.json())
        .then(data => {
          if (data.success) {
            alert("選択した回答を正解として登録しました。");
            location.reload();
          } else {
            alert(data.error || '登録に失敗しました。');
          }
        }).catch(error => {
          console.error('Error:', error);
          alert('登録に失敗しました。');
        }).finally(() => {
          modal.style.display = "none";
        });
      }, {once: true});

      cancelBtn.addEventListener('click', function() {
        modal.style.display = "none";
      }, {once: true});
    });
  });
});


/*==========================*/
/* XX - ユーザー情報編集ページ  */
/*=========================*/
document.getElementById('avatar-upload').addEventListener('change', function(event) {
  var file = event.target.files[0];
  var errorMessage = document.getElementById('error-message');
  var previewImage = document.getElementById('avatar-image');

  errorMessage.style.display = 'none';
  errorMessage.textContent = '';

  // ファイルのバリデーション
  if (!file) {
    return;
  }

  var validTypes = ['image/jpeg', 'image/png'];
  var validExtensions = ['.jpg', '.jpeg', '.png'];
  var fileExtension = file.name.substring(file.name.lastIndexOf('.')).toLowerCase();

  if (!validTypes.includes(file.type) || !validExtensions.includes(fileExtension)) {
    errorMessage.style.display = 'block';
    errorMessage.textContent = '非対応のファイルです';
    event.target.value = '';
    return;
  }

  // ファイルのプレビュー処理とクロップ処理
  var reader = new FileReader();

  reader.onload = function(e) {
    showCropPopup(e.target.result);
  };

  reader.readAsDataURL(file);
});

// 画像切り抜きポップアップを表示する関数
function showCropPopup(imageSrc) {
  var overlay = document.createElement('div');
  overlay.classList.add('popup-overlay');

  var popup = document.createElement('div');
  popup.classList.add('popup');

  // オーバーレイにポップアップを追加
  overlay.appendChild(popup);
  // ドキュメントにオーバーレイを追加
  document.body.appendChild(overlay);

  var img = document.createElement('img');
  img.id = 'crop-image';
  img.src = imageSrc;

  var cropOkButtonArea = document.createElement('div');
  cropOkButtonArea.classList.add('crop-ok-button-area');

  var okButton = document.createElement('button');
  okButton.textContent = 'OK';
  okButton.classList.add('crop-ok-button');

  cropOkButtonArea.appendChild(okButton);

  popup.appendChild(img);
  popup.appendChild(cropOkButtonArea);

  // Cropperを初期化
  var cropper = new Cropper(img, {
    aspectRatio: 1,
    viewMode: 1,
  });

  okButton.addEventListener('click', function() {
    var canvas = cropper.getCroppedCanvas({
      width: 115,
      height: 115,
      fillColor: '#fff',
    });

    if (!canvas) {
      console.error('キャンバスの作成に失敗しました');
      return;
    }

    // avatar-imageのsrcを更新
    var previewImage = document.getElementById('avatar-image');
    previewImage.src = canvas.toDataURL('image/jpeg');

    // クロップした画像をBlobに変換し、新しいFileオブジェクトとしてファイル入力にセット
    canvas.toBlob(function(blob) {
      var croppedFile = new File([blob], 'avatar.jpg', { type: 'image/jpeg' });

      // 新しいDataTransferオブジェクトを作成し、クロップしたファイルを追加
      var dataTransfer = new DataTransfer();
      dataTransfer.items.add(croppedFile);

      // ファイル入力に新しいファイルをセット
      var fileInput = document.getElementById('avatar-upload');
      fileInput.files = dataTransfer.files;
    }, 'image/jpeg');

    // Cropperとオーバーレイを削除
    cropper.destroy();
    document.body.removeChild(overlay);
  });
}

document.addEventListener('DOMContentLoaded', function() {
  var closeButton = document.getElementById('close-popup');
  if (closeButton) {
    closeButton.addEventListener('click', function() {
      var popup = document.getElementById('error-popup');
      popup.style.display = 'none';
    });
  }
});

// 更新に失敗した際の処理（ポップアップ）
document.addEventListener("DOMContentLoaded", function() {
  // ポップアップの閉じるボタン
  $('#close-popup').on('click', function() {
    $('#update-error-popup').fadeOut();
    // スクロールを再度有効化
    $('body').css('overflow', 'auto');
  });
});