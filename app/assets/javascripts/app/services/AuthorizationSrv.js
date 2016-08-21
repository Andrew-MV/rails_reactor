reactorApp.factory('AuthorizationSrv', function($http, $q, $rootScope) {

    return {
        signUp: function(login, password) {
            var defer = $q.defer();
            $http.post('api/sign-up', {
                login: login,
                password: password
            }).then(function (response) {
                $rootScope.user = response
                //defer.resolve(response.data);
            }).catch(function (error) {
                //defer.reject(error.data.message);
            });
            return defer.promise;
        },

        signIn: function(login, password) {
            var defer = $q.defer();
            $http.post('api/sign-in', {
                login: login,
                password: password
            }).then(function (response) {
                $rootScope.user = response
                //defer.resolve(response.data);
            }).catch(function (error) {
                //defer.reject(error.data.message);
            });
            return defer.promise;
        },

        logOut: function() {
            // todo
            $rootScope.user = null;
            var defer = $q.defer();
            // $http.post('api/correlate', {
            //     dataset2: dataset2
            // }).then(function (response) {
            //     defer.resolve(response.data);
            // }).catch(function (error) {
            //     defer.reject(error.data.message);
            // });
            return defer.promise;
        }
    };

});