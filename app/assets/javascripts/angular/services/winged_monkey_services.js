var wingedMonkeyServices = angular.module('wingedMonkeyServices', ['ngResource']);

wingedMonkeyServices.factory("ProviderApplication", function($resource){
  return $resource('provider_applications/:id', {id: "@id"}, {});
});
