var wingedMonkeyControllers = angular.module('wingedMonkeyControllers',[]);

wingedMonkeyControllers.controller("ProviderAppsCtrl", function($scope, $filter, ProviderApplication) {
  $scope.appsLoaded = false;

  $scope.refreshProviderApps = function() {
    ProviderApplication.query(function(data){
      $scope.providerApps = data;
      $scope.appsLoaded = true;
      setTimeout($scope.refreshProviderApps, 20000);
    });
  };

  $scope.refreshProviderApps();

  $scope.destroyProviderApp = function(app_id) {
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.$delete({id: app.id}, function(response) {
          response.state = "DELETING"
          // $scope.providerApps.splice(index, 1);
        }, function(response){
          //failure
          console.log(response);
        });
      }
    });
  };

  $scope.startProviderApp = function(app_id) {
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.$start({id: app.id, action: "start"}, function(response) {
          response.state = "STARTING";
        }, function(response){
          //failure
          console.log(response);
        });
      }
    });
  };

  $scope.stopProviderApp = function(app_id) {
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.$stop({id: app.id, action: "stop"}, function(response) {
          response.state = "STOPPING";
        }, function(response){
          //failure
          console.log(response);
        });
      }
    });
  };

  $scope.pauseProviderApp = function(app_id) {
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.$pause({id: app.id, action: "pause"}, function(response) {
          //success
          response.state = "PAUSING";
        }, function(response){
          //failure
          console.log(response);
        });
      }
    });
  };
});
