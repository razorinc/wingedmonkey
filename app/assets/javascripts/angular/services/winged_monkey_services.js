var wingedMonkeyServices = angular.module('wingedMonkeyServices', ['ngResource']);

wingedMonkeyServices.factory("ProviderApplication", function($resource){
  return $resource('provider_applications/:id/:action', {id: "@id"}, {
    'start': { method: 'POST', params:{action:'start'} },
    'stop': { method: 'POST', params:{action:'stop'} },
    'pause': { method: 'POST', params:{action:'pause'} }
  });
});

wingedMonkeyServices.factory("FlashMessage", function() {
  var flashMessages = [];

  return {
    all: function() {
      return flashMessages;
    },
    add: function(type, content) {
      flashMessages.push({type: type, content: content});
    },
    remove: function(message) {
      var index = flashMessages.indexOf(message);
      flashMessages.splice(index, 1);
    },
    removeAll: function() {
      flashMessages.length = 0;
    }
  }
});
