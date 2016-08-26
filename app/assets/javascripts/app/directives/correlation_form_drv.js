reactorApp.directive('correlationFormDrv', function(AnalyserSrv, NotifierSrv) {
    return {
        restrict: 'E',
        scope: {
            results: '='
        },
        templateUrl: 'correlation_form.html',
        link: function(scope, element, attrs) {
            scope.loading = false;
            // scope.dataset1 = null;
            // scope.dataset2 = null;
            scope.correlate = function() {
                if (scope.loading) {
                    return;
                }
                scope.loading = true;
                AnalyserSrv
                    .correlate(scope.dataset1, scope.dataset2)
                    .then(function(result) {
                        scope.results = result;
                    })
                    .catch(function(message) {
                        scope.results = {};
                        NotifierSrv.error(message);
                    })
                    .finally(function() {
                        scope.loading = false;
                    });
            };
        }
    };
})