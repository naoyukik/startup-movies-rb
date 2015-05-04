$(function(){
  function viewModel() {};
  viewModel.prototype = {
    datas: function() {
      return data = [
      {
        id: '53',
        site_name: 'Title',
        provider: '1',
        movie_url: "xohXWgCpsD0",
        created_at: "2015-03-24 14:24:07.254767",
        update_at: "2015-03-24 14:24:07.254767"
      },
      {
        id: '54',
        site_name: 'Title',
        provider: '1',
        movie_url: "gzXV_9Aaxk8",
        created_at: "2015-03-24 14:24:07.30877",
        update_at: "2015-03-24 14:24:07.30877"
      },
      ];
    },

    // 初期データの取得
    getData: function() {
      $.ajax({
        url: '/api/site',
        type: 'GET'
      }).done(function(movieData) {
        console.log(movieData);
        return movieData;
      })
    }
  }

  ons.bootstrap();

  // Trigger
  var vm = new viewModel();
  var siteData = vm.getData();
  ko.applyBindings(siteData);
})
