// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require canvasjs.min
//= require activestorage
//= require_tree .

// フラッシュメッセージ
$(document).on('turbolinks:load', function() {
  const showMessage = (message, type) => {
    $("#flash-popup-message").text(message);
    $("#flash-popup").addClass(type).fadeIn("slow");
  };

  const closeMessage = () => {
    $("#flash-popup").fadeOut("slow", function() {
      $(this).removeClass("alert notice");
    });
  };

  const message = $("#flash-popup").data("message");
  const messageType = $("#flash-popup").data("message-type");

  if (message && messageType) {
    showMessage(message, messageType);
    setTimeout(closeMessage, 3000); // 3秒後に自動的に消える
  }

  $("#flash-popup-close").on("click", closeMessage);
});

