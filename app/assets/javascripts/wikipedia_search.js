$(document).ready(function() {
  console.log("Document is ready")
  $('#comment_content').on('input', function() {
    var input = $(this).val();
    if (input.length > 2) {
      $.ajax({
        url: 'https://en.wikipedia.org/w/api.php',
        data: { action: 'opensearch', search: input, format: 'json', limit: 5 },
        dataType: 'jsonp',
        success: function(data) {
          $('#search-results').empty();
          var results = data[1];
          results.forEach(function(result) {
            $('#search-results').append('<li>' + result + '</li>');
          });
          if (results.length > 0) {
            $('#search-results').show();
          } else {
            $('#search-results').hide();
          }
        }
      });
    } else {
      $('#search-results').hide();
    }
  });
});