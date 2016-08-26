reactorApp.controller('ApplicationCtrl', function($rootScope) {

    $rootScope.user = null;
    $rootScope.isUnauthorized = function() {
        return $rootScope.user === null;
    };

});