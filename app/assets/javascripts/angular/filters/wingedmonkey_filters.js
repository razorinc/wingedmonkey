var wingedMonkeyFilters = angular.module('wingedMonkeyFilters',[]);

wingedMonkeyFilters.filter('findById', function($filter) {
  return function(input, id){
    if(typeof input !== 'undefined'){
      return $filter('filter')(input, { id: id })[0];
    }
  };
});
