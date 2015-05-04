var module = ons.bootstrap('my-app', ['onsen']);
// module.controller('AppController', function($scope) { });
module.controller('PageController', function($scope) {
  ons.ready(function() {
    // Init code here
  });
});
module.controller('AppController', ['$scope', '$http', '$q', '$sce', function($scope, $http, $q, $sce) {
  $scope.MyDelegate = {
    configureItemScope : function(index, itemScope) {
      if (!itemScope.item) {
        itemScope.canceler = $q.defer();
        // var siteData = this.getSiteData(index+1, itemScope);
        // console.log('siteData => '+siteData);
        console.log("Created item #" + index);
        itemScope.item = {
          name: '要素 No.' + (index + 1)
        };
        var siteData = this.getSiteData((index+1), itemScope);
      }
    },
    calculateItemHeight : function(index) {
      return 380;
    },
    countItems: function() {
      return lazyMaxItemCount;
    },
    destroyItemScope: function(index, itemScope) {
      itemScope.canceler.resolve();
      console.log("Destroyed item #" + index);
    },
    // サイトデータの取得
    getSiteData : function(index, itemScope) {
        var config = {
          params: {page: index},
          timeout: itemScope.canceler.promise
        };
        console.log('config => '+config['params']['page']);
        $http.get('/api/site', config)
        .success(function(data) {
          itemScope.item = {
            name: $sce.trustAsHtml(angular.fromJson(data)[0])
          };
        })
        .error(function() {
          console.log('error!!');
          // itemScope.item.name = 'No bacon';
        });
    },
  };

}]);
