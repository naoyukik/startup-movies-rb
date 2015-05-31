var module = ons.bootstrap('my-app', ['onsen', 'toaster']);
module.controller('AppController', ['$scope', '$http', '$q', '$sce', 'toaster', function($scope, $http, $q, $sce, toaster) {
  $scope.MyDelegate = {
    configureItemScope : function(index, itemScope) {
      if (!itemScope.item) {
        itemScope.canceler = $q.defer();
        // var siteData = this.getSiteData(index+1, itemScope);
        // console.log('siteData => '+siteData);
        // console.log('Created item #' + index);
        itemScope.item = {
          name: 'blank'
        };
        var siteData = this.getSiteData((index + 1), itemScope);
      }
    },
    calculateItemHeight : function(index) {
      return 320;
    },
    countItems: function() {
      return lazyMaxItemCount;
    },
    destroyItemScope: function(index, itemScope) {
      itemScope.canceler.resolve();
      // console.log('Destroyed item #' + index);
    },
    // サイトデータの取得
    getSiteData : function(index, itemScope, errorCount) {
      var errorCount = (errorCount === undefined) ? 0 : errorCount;
      var config = {
        params: {page: index},
        timeout: itemScope.canceler.promise
      };
      // console.log('config => ' + config['params']['page']);
      $http.get('/api/site', config)
      .success(function(data) {
        // console.log(angular.fromJson(data)[0]);
        itemScope.item = {
          name: $sce.trustAsHtml(angular.fromJson(data)[0])
        };
      })
      .error(function() {
        // console.log('error!! => ' + index);
        // console.log(errorCount);
        if (errorCount < 1) {
          console.log('error loop');
          errorCount = 1;
          arguments.callee(index, itemScope, errorCount)
        }
        // itemScope.item.name = 'No bacon';
      });
    },
  };
  $scope.createSiteData = function() {
    var config = {
      params: {url: this.query}
    };
    // console.log('config => ' + config['params']['url']);
    $http.post('/api/create', config)
    .success(function(data) {
      toaster.pop('success', null, 'success', 2000);
    })
    .error(function(data) {
      console.log(data);
      toaster.pop('error', null, 'error', 2000);
    })
  };
}]);
