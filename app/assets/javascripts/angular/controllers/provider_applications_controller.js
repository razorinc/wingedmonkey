var wingedMonkey = angular.module('wingedMonkey',['ngResource']);

wingedMonkey.controller("ProviderAppsCtrl", function($scope, $http) {

  $http.get('/provider_applications.json').success(function(data) {
    $scope.provider_apps = data;
  });

  // $scope.provider_apps = ProviderApplication.query();

  // $scope.provider_apps = [
  //     {state:"angular_state", launchable:"angular_launchable"},
  //     {state:"angular_state2", launchable:"angular_launchable2"}
  // ];

});
