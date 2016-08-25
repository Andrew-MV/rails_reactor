reactorApp.controller('HomePageCtrl', function($scope, $http, AnalyserSrv, NotifierSrv, AuthorizationSrv) {

    $scope.loading = false;
    $scope.results = {};
    $scope.analyzeMode = true;
    $scope.correlationMode = false;
    $scope.login = '';
    $scope.password = '';

    $scope.enableAnalyzeMode = function() {
        $scope.analyzeMode = true;
        $scope.correlationMode = false;
    };

    $scope.enableCorrelationMode = function() {
        $scope.analyzeMode = false;
        $scope.correlationMode = true;
    };

    $scope.logOut = function() {
        AuthorizationSrv
            .logOut()
            .then(function() {
                NotifierSrv.success('Logged out')
            })
            .catch(function(message) {
                NotifierSrv.error(message)
            })
            .finally(function() {
            });
    };
});