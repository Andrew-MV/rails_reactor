reactorApp.factory('AnalyserSrv', function($http, $q) {

    return {
        analyze: function (dataset) {
            var defer = $q.defer();
            $http.post('api/analyze', {
                dataset: dataset
            }).then(function (response) {
                defer.resolve(response.data);
            }).catch(function (error) {
                defer.reject(error.data.message);
            });
            return defer.promise;
        },
        correlate: function (dataset1, dataset2) {
            var defer = $q.defer();
            $http.post('api/correlate', {
                dataset1: dataset1,
                dataset2: dataset2
            }).then(function (response) {
                defer.resolve(response.data);
            }).catch(function (error) {
                defer.reject(error.data.message);
            });
            return defer.promise;
        }
    };

});