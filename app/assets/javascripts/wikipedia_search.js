$(document).ready(function() {
  var textArea = $('#comment_content');
  textArea.on('input', function() {
    var input = $(this).val();
    if (input) {
      $.ajax({
        url: 'https://ja.wikipedia.org/w/api.php',
        data: {
          action: 'opensearch',
          search: input,
          format: 'json'
        },
        dataType: 'jsonp',
        success: function(data) {
          if (data[1]) {
            var results = [];
            for (var i = 0; i < data[1].length; i++) {
              results.push(data[1][i]);
            }
            $('#search-results').html(results.join('<br>'));
            $('#search-results').css('display', 'block');
          } else {
            console.log('No results found');
            $('#search-results').html('');
            $('#search-results').css('display', 'none');
          }
        }
      });
    } else {
      $('#search-results').html('');
      $('#search-results').css('display', 'none');
    }
  });
});

$(document).on('click', '#search-results li', function() {
  $('#comment_content').val($(this).text());
  $('#search-results').hide();
});
