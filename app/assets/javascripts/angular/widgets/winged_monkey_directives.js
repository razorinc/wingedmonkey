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
      action: '@',
      confirmAction: '&',
      confirmTitle: '@',
      cancel: '@'
    },
    templateUrl: "assets/wm_provider_app_confirm.html",
    link: function(scope, element, attrs) {

      var initialButton = angular.element(element.children()[0]);
      var message = angular.element(element.children()[1]);
      var confirmButton = angular.element(message.children()[1]);
      var cancelButton = angular.element(message.children()[2]);

      initialButton.bind('click', open);
      confirmButton.bind('click', close);
      cancelButton.bind('click', close);

      function open() {
        message.addClass('js_show');
        message.removeClass('js_hide');
        initialButton.addClass('active');
        initialButton.attr("disabled", "true");
      }

      function close() {
        message.addClass('js_hide');
        message.removeClass('js_show');
        initialButton.removeClass('active');
        initialButton.removeAttr("disabled");
      }
    }
  }
});
