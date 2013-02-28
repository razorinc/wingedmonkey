var wingedMonkeyControllers = angular.module('wingedMonkeyControllers',[]);

wingedMonkeyControllers.controller("ProviderAppsCtrl", function($scope, $timeout, ProviderApplication) {
  $scope.appsLoaded = false;
  $scope.sort = { predicate: "name", reverse: false };

  var timeoutPromise;
  var timeoutDelay = 15000;

  $scope.refreshProviderApps = function() {
    ProviderApplication.query(function(data){
      $scope.providerApps = data;
      $scope.appsLoaded = true;
      timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
    });
  };

  $scope.refreshProviderApps();

  $scope.destroyProviderApp = function(app_id) {
    $timeout.cancel(timeoutPromise);
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$delete({id: app.id}, function(response) {
          //success
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
        }, function(response){
          //failure
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
          console.log(response);
        });
      }
    });
  };

  $scope.startProviderApp = function(app_id) {
    $timeout.cancel(timeoutPromise);
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$start({id: app.id}, function(response) {
          //success
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
        }, function(response){
          //failure
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
          console.log(response);
        });
      }
    });
  };

  $scope.stopProviderApp = function(app_id) {
    $timeout.cancel(timeoutPromise);
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$stop({id: app.id}, function(response) {
          //success
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
        }, function(response){
          //failure
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
          console.log(response);
        });
      }
    });
  };

  $scope.pauseProviderApp = function(app_id) {
    $timeout.cancel(timeoutPromise);
    $scope.providerApps.forEach(function(app, index) {
      if (app_id === app.id) {
        app.wm_state = "PENDING"
        app.disableButtons = true;
        app.$pause({id: app.id}, function(response) {
          //success
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
        }, function(response){
          //failure
          timeoutPromise = $timeout($scope.refreshProviderApps, timeoutDelay);
          console.log(response);
        });
      }
    });
  };

});
