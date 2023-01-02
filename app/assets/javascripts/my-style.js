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
