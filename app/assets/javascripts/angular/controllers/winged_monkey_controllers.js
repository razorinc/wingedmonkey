var wingedMonkeyControllers = angular.module('wingedMonkeyControllers',[]);

wingedMonkeyControllers.controller("ProviderAppsCtrl", function($scope, $filter, ProviderApplication) {
  $scope.appsLoaded = false;

  $scope.refreshProviderApps = function() {
    ProviderApplication.query(function(data){
      $scope.providerApps = data;
      $scope.appsLoaded = true;
    });
  };

  $scope.refreshProviderApps();

  $scope.destroyProviderApp = function(app_id) {
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.$delete({id: app.id}, function() {
          //success
          $scope.providerApps.splice(index, 1);
        }, function(response){
          //failure
          console.log(response);
        });
      }
    });
  };
});
