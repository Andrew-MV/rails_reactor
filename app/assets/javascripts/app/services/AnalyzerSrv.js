reactorApp.factory('AnalyserSrv', function($http, $q) {

    return {
        analyze: function (dataset) {
            var defer = $q.defer();

            //console.log('inside analyze');
            $http.post('api/analyze', {
                dataset: dataset
            }).then(function (response) {
                //console.log(response),
                defer.resolve(response.data);
            }).catch(function (error) {
                //console.log(error, 'error')
                defer.reject(error);
            });
            return defer.promise;
        }
    };

});