var wingedMonkeyServices = angular.module('wingedMonkeyServices', ['ngResource']);

wingedMonkeyServices.factory("ProviderApplication", function($resource){
  return $resource('provider_applications/:id/:action', {id: "@id"}, {
      'start': { method: 'POST', params:{action:'start'} },
      'stop': { method: 'POST', params:{action:'stop'} },
      'pause': { method: 'POST', params:{action:'pause'} }
  });
});
