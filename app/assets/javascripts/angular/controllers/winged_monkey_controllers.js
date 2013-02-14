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
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$delete({id: app.id}, function(response) {
          //success
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
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$start({id: app.id}, function(response) {
          //success
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
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$stop({id: app.id}, function(response) {
          //success
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
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$pause({id: app.id}, function(response) {
          //success
        }, function(response){
          //failure
          console.log(response);
        });
      }
    });
  };
});
