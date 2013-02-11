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
