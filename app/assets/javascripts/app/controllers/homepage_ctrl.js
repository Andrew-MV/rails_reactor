reactorApp.controller('HomePageCtrl', function($scope, $http, AnalyserSrv) {

    $scope.results = {};

    $scope.analyze = function() {
        $scope.results = AnalyserSrv.analyze($scope.dataset)
            .then(function(result) {
                //console.log('inside then');
                $scope.results = result;
            })
            .catch(function(error) {
                //console.log('inside catch');
            });
        //console.log('analyyyyse');
    };

});