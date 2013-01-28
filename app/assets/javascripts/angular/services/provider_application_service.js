var providerApplicationService = angular.module('providerApplicationService', ['ngResource']);

providerApplicationService.factory("ProviderApplication", function($resource){
  return $resource('/provider_applications.json', {}, {});
});
