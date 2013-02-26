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
      var confirm_message = angular.element(element.children()[1]);
      var confirmButton = angular.element(angular.element(confirm_message.children()[1]).children()[0]);
      var cancelButton = angular.element(angular.element(confirm_message.children()[1]).children()[1]);

      initialButton.bind('click', open);
      confirmButton.bind('click', close);
      cancelButton.bind('click', cancel);

      function open() {
        confirm_message.addClass('js_show');
        confirm_message.removeClass('js_hide');
        initialButton.addClass('active');
        initialButton.attr("disabled", "true");
      }

      function close() {
        confirm_message.addClass('js_hide');
        confirm_message.removeClass('js_show');
        initialButton.removeClass('active');
      }

      function cancel() {
        close();
        initialButton.removeAttr("disabled");
      }
    }
  }
});
