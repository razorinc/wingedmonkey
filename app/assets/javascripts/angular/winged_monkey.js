var wingedMonkey = angular.module('wingedMonkey',['wingedMonkeyControllers','wingedMonkeyServices', 'wingedMonkeyFilters', 'wingedMonkeyDirectives']);

wingedMonkey.config(["$httpProvider", function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}])
