$(document).ready(function() {
  $('#modal-button').click(function() {
    $('#modal-notes').show();
    $('#modal-form').hide();
  });

  $('#disagree-button').click(function() {
    $('#modal-notes').hide();
  });

  $('#agree-button').click(function() {
    $('#modal-notes').hide();
    $('#modal-form').show();
  });

  $('#cancel-button').click(function() {
    $('#modal-form').hide();
  });

  $('#form-submit-button').click(function() {
    // ここにフォーム送信のロジックを追加
    $('#modal-form').hide();
  });
});
