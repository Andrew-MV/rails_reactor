reactorApp.factory('AnalyserSrv', function($http, $q, ResponseErrorSrv, ResponseSuccessSrv) {

    return {
        analyze: function (dataset) {
            var defer = $q.defer();
            $http.post('api/analyze', {
                meta: {
                    dataset: dataset
                }
            }).then(function (response) {
                defer.resolve(ResponseSuccessSrv.getMeta(response));
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },
        correlate: function (dataset1, dataset2) {
            var defer = $q.defer();
            $http.post('api/correlate', {
                meta: {
                    dataset1: dataset1,
                    dataset2: dataset2
                }
            }).then(function (response) {
                defer.resolve(ResponseSuccessSrv.getMeta(response));
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        }
    };

});