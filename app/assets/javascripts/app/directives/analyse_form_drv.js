reactorApp.directive('analyseFormDrv', function(AnalyserSrv, NotifierSrv) {
    return {
        restrict: 'E',
        scope: {},
        templateUrl: 'analyse_form.html',
        link: function(scope, element, attrs) {
            scope.loading = false;
            scope.analyze = function() {
                if (scope.loading) {
                    return;
                }
                scope.loading = true;
                AnalyserSrv
                    .analyze(scope.dataset)
                    .then(function(result) {
                        scope.results = result;
                    })
                    .catch(function(message) {
                        NotifierSrv.error(message);
                    })
                    .finally(function() {
                        scope.loading = false;
                    });
            };
        }
    };
})