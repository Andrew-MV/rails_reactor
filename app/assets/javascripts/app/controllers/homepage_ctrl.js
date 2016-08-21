reactorApp.controller('HomePageCtrl', function($scope, $http, AnalyserSrv, NotifierSrv) {

    $scope.loading = false;
    $scope.results = {};
    $scope.analyzeMode = true;
    $scope.correlationMode = false;

    $scope.analyze = function() {
        if ($scope.loading) {
            return;
        }
        $scope.loading = true;
        AnalyserSrv
            .analyze($scope.dataset)
            .then(function(result) {
                //console.log('inside then');
                $scope.results = result;
            })
            .catch(function(message) {
                NotifierSrv.error(message)
            })
            .finally(function() {
                $scope.loading = false;
            });
    };

    $scope.correlate = function() {
        //console.log('this method works')
        if ($scope.loading) {
            return;
        }
        $scope.loading = true;
        AnalyserSrv
            .correlate($scope.dataset1, $scope.dataset2)
            .then(function(result) {
                //console.log('inside then');
                $scope.results = result;
            })
            .catch(function(message) {
                NotifierSrv.error(message)
            })
            .finally(function() {
                $scope.loading = false;
            });
    };

    $scope.enableAnalyzeMode = function() {
        $scope.analyzeMode = true;
        $scope.correlationMode = false;
    };

    $scope.enableCorrelationMode = function() {
        $scope.analyzeMode = false;
        $scope.correlationMode = true;
    };

});