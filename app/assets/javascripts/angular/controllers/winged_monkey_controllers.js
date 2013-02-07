var wingedMonkeyControllers = angular.module('wingedMonkeyControllers',[]);

wingedMonkeyControllers.controller("ProviderAppsCtrl", function($scope, $filter, ProviderApplication, $http) {
  $scope.appsLoaded = false;

  $scope.refreshProviderApps = function() {
    ProviderApplication.query(function(data){
      $scope.providerApps = data;
      $scope.appsLoaded = true;
    });
  };

  $scope.refreshProviderApps();
});
