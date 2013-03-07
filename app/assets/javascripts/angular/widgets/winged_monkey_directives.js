var wingedMonkeyDirectives = angular.module('wingedMonkeyDirectives',[]);

// Toggle directive
wingedMonkeyDirectives.directive('wmToggle', function () {
  return function (scope, elm, attrs) {
    scope.$watch(attrs.wmToggle, function (newVal, oldVal) {
      if (newVal) {
        elm.removeClass('js_hide').addClass('js_show');
      } else {
        elm.removeClass('js_show').addClass('js_hide');
      }
    });
  };
});

wingedMonkeyDirectives.directive('wmProviderAppConfirm', function() {
  return{
    restrict: "A",
    replace: true,
    scope: {
      message: '@wmProviderAppConfirm',
      providerApp: '=',
      toggleProperty: '=',
      action: '@',
      confirmAction: '&',
      confirmTitle: '@',
      cancel: '@'
    },
    templateUrl: "/directive_templates/wm_provider_app_confirm",
    link: function(scope, element, attrs) {
      var initialButton = angular.element(element.children()[0]);

      scope.$watch(attrs.toggleProperty, function (newVal, oldVal) {
        if (newVal) {
          initialButton.addClass('active');
          scope.providerApp.disableButtons = true;
        } else {
          initialButton.removeClass('active');
        }
      });

      scope.cancelAction = function() {
        scope.providerApp.disableButtons = false;
      }
    }
  }
});

wingedMonkeyDirectives.directive('wmFlashMessage', function($rootScope) {
  return {
    restrict: 'A',
    templateUrl: "/directive_templates/wm_flash_message",
    controller: function($scope, $attrs) {
      $scope.clear = function(){
        $rootScope.flashMessages = [];
      }

      $scope.clear();
    },
    link: function(scope, element, attrs) {

    }
  }
});
