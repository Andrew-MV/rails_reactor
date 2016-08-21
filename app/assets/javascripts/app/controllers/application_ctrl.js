reactorApp.controller('ApplicationCtrl', function($rootScope) {

    $rootScope.user = null;
    $rootScope.isUnauthorized = function() {
        return $rootScope.user === null;
    };

    // $scope.loading = false;
    //
    // $scope.analyze = function() {
    //     if ($scope.loading) {
    //         return;
    //     }
    //     $scope.loading = true;
    //     AnalyserSrv
    //         .analyze($scope.dataset)
    //         .then(function(result) {
    //             //console.log('inside then');
    //             $scope.results = result;
    //         })
    //         .catch(function(message) {
    //             NotifierSrv.error(message)
    //         })
    //         .finally(function() {
    //             $scope.loading = false;
    //         });
    // };

});