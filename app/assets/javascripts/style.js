/*カテゴリ用ドロップダウンメニュー*/
$('.post-dropdown').click(function () {
  $(this).attr('tabindex', 1).focus();
  $(this).toggleClass('active');
  $(this).find('.post-dropdown-menu').slideToggle(300);
});
$('.post-dropdown').focusout(function () {
  $(this).removeClass('active');
  $(this).find('.post-dropdown-menu').slideUp(300);
});
$('.post-dropdown .post-dropdown-menu li').click(function () {
  $(this).parents('.post-dropdown').find('span').text($(this).text());
  $(this).parents('.post-dropdown').find('input').attr('value', $(this).attr('id'));
});


$('.post-dropdown-menu li').click(function () {
var input = '<strong>' + $(this).parents('.post-dropdown').find('input').val() + '</strong>',
msg = '<span class="msg">Hidden input value: ';
$('.msg').html(msg + input + '</span>');
}); 


/* ファイルアップロードフォーム */
$(document).ready(function() {
  var currentImageIndex = 0;
  var images = [];

  $('#post_image').on('change', function(event) {
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
    navigator.sendBeacon('/posts/cleanup_temp_files');
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
        fetch(`/posts/${modal.dataset.postId}/answers/${answerId}/confirm`, {
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