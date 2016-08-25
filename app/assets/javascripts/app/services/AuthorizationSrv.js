reactorApp.factory('AuthorizationSrv', function($http, $q, $rootScope, $cookies, ResponseErrorSrv) {

    return {
        verifyToken: function() {
            var defer = $q.defer();
            $http.post('api/verify-token', {
                authorization_token: $cookies.get('authorization_token')
            }).then(function (response) {
                defer.resolve(response);
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },
        
        signUp: function(login, password) {
            var defer = $q.defer();
            $http.post('api/sign-up', {
                login: login,
                password: password
            }).then(function (response) {
                $rootScope.user = response.data.user;
                $cookies.put('authorization_token', response.data.meta.authorization_token);
                defer.resolve(response.data);
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },

        signIn: function(login, password) {
            var defer = $q.defer();
            $http.post('api/sign-in', {
                login: login,
                password: password
            }).then(function (response) {
                $rootScope.user = response.data.user;
                $cookies.put('authorization_token', response.data.meta.authorization_token);
                defer.resolve(true);
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },

        logOut: function() {
            var defer = $q.defer();
            $http.post('api/log-out', { })
                .then(function (response) {
                    defer.resolve(response.data);
                    $cookies.remove('authorization_token');
                    $rootScope.user = null;
                })
                .catch(function (response) {
                    defer.reject(ResponseErrorSrv.getTitle(response));
                });
            return defer.promise;
        }
    };

});