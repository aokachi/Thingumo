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
              results.push('<li class="search-result-item">' + data[1][i] + '</li>');
            }
            $('#search-results').html(results.join(''));
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

$(document).on('click', '.search-result-item', function() {
  var text = $(this).text();
  $('#comment_content').val(text);
  $('#search-results').hide();
});
