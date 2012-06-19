(function () {
  $('.typeahead').typeahead({
    source: [ 'foo', 'bar', 'baz', 'bazinga' ]
  });
}());

getUserRecommendations = function(userId) {
  $('#links').empty();

  $.getJSON('/api/users/' + userId, function (data) {
    $.each(data['recommendations'], function (itemId) {
      $('#links').append('<tr><td>' + data['recommendations'][itemId]['item'] + '</td><td>' + data['recommendations'][itemId]['score'] + '</td></tr>');
    });
  }).error(function (data) {
    if(data.status == 404) {
      $('#links').append("<div class=\"alert alert-error\">User not found!</div>");
    }
  });
};

$('#recommend').click(function (event) {
  getUserRecommendations($('#username').val());
});
