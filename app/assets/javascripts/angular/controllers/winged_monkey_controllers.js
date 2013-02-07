var wingedMonkeyControllers = angular.module('wingedMonkeyControllers',[]);

wingedMonkeyControllers.controller("ProviderAppsCtrl", function($scope, $filter, ProviderApplication) {
  $scope.refreshProviderApps = function() {
    ProviderApplication.query(function(data){
      $scope.providerApps = data;
    });
  };

  $scope.refreshProviderApps();
});
