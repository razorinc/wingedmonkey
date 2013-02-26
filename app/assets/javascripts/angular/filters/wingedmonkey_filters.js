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
    // if(typeof input == 'undefined'){
    if(input == null){
      return replacementString;
    } else {
      return input;
    }
  };
});
