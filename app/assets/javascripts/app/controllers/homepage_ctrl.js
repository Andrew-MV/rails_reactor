reactorApp.controller('HomePageCtrl', function($scope, $http, AnalyserSrv, NotifierSrv) {

    $scope.loading = false;

    $scope.results = {};

    $scope.analyze = function() {
        if ($scope.loading) {
            return;
        };
        $scope.loading = true;
        AnalyserSrv
            .analyze($scope.dataset)
            .then(function(result) {
                //console.log('inside then');
                $scope.results = result;
                $scope.loading = false;
            })
            .catch(function(message) {
                NotifierSrv.error(message)
                $scope.loading = false;
            });
    };

});