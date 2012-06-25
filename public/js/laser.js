(function ($, window, undefined) {

    $('.typeahead').typeahead({
        source: function (typeahead, query) {
          return $.getJSON('/api/autocomplete/' + query + '/limit/20', { }, function (data) {
              values = $.map(data.results, function (val) {
                  return { value: val };
                });
              return typeahead.process(values);
            });
        }
      });

    getUserRecommendations = function(userId) {
      $('#links').empty();

      $.getJSON('/api/users/' + userId, function (data) {
          $.each(data['recommendations'], function (itemId) {
              $.getJSON('/api/urls/' + data['recommendations'][itemId]['item'], function (data_mapped) {
                  $('#links').append('<tr><td><a href=\"' +  data_mapped['url']+ '\">'+ data_mapped['title'] + '</a> </td><td>' + data['recommendations'][itemId]['item'] + '</td></tr>');
                });
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

    }(jQuery, window));

