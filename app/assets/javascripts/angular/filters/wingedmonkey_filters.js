var wingedMonkeyFilters = angular.module('wingedMonkeyFilters',[]);

wingedMonkeyFilters.filter('findById', function($filter) {
  return function(input, id){
    if(typeof input !== 'undefined'){
      return $filter('filter')(input, { id: id })[0];
    }
  };
});

// replace undefined with N/A string (custom string is passed)
wingedMonkeyFilters.filter('notAvailable', function($filter) {
  return function(input, replacementString){
    if(input == null){
      return replacementString;
    } else {
      return input;
    }
  };
});

wingedMonkeyFilters.filter('capitalize', function() {
  return function(input, scope) {
    return input.substring(0,1).toUpperCase()+input.substring(1);
  }
});
