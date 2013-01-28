var wingedMonkey = angular.module('wingedMonkey',['providerApplicationService', 'wingedMonkeyFilters']);

wingedMonkey.controller("ProviderAppsCtrl", function($scope, $filter, ProviderApplication) {
  $scope.refreshProviderApps = function() {
    ProviderApplication.query(function(data){
      $scope.providerApps = data;
    });
  };

  $scope.refreshProviderApps();
});
