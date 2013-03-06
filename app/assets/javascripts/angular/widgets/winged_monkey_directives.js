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
    templateUrl: "assets/wm_provider_app_confirm.html",
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
