$(document).ready(function() {
  var textArea = $('#comment_content');
  textArea.on('input', function() {
    var input = $(this).val();
    if (input) {
      $.ajax({
        url: 'https://en.wikipedia.org/w/api.php',
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
          } else {
            console.log('No results found');
            $('#search-results').html('');
          }
        }
      });
    } else {
      $('#search-results').html('');
    }
  });
});
