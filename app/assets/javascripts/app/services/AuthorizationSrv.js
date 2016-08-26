reactorApp.factory('AuthorizationSrv', function($http, $q, $rootScope, $cookies, ResponseErrorSrv, ResponseSuccessSrv) {

    return {
        verifyToken: function() {
            var defer = $q.defer();
            $http.post('api/verify-token', {
                meta: {
                    authorization_token: $cookies.get('authorization_token')
                }
            }).then(function (response) {
                defer.resolve(ResponseSuccessSrv.getMeta(response));
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },
        
        signUp: function(login, password) {
            var defer = $q.defer();
            $http.post('api/sign-up', {
                meta: {
                    login: login,
                    password: password
                }
            }).then(function (response) {
                $rootScope.user = ResponseSuccessSrv.getUser(response);
                $rootScope.meta = ResponseSuccessSrv.getMeta(response);
                $cookies.put('authorization_token', $rootScope.meta.authorization_token);
                defer.resolve($rootScope.user);
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },

        signIn: function(login, password) {
            var defer = $q.defer();
            $http.post('api/sign-in', {
                meta: {
                    login: login,
                    password: password
                }
            }).then(function (response) {
                $rootScope.user = ResponseSuccessSrv.getUser(response);
                $rootScope.meta = ResponseSuccessSrv.getMeta(response);
                $cookies.put('authorization_token', $rootScope.meta.authorization_token);
                defer.resolve($rootScope.user);
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },

        logOut: function() {
            var defer = $q.defer();
            $http.post('api/log-out', { meta: {} })
                .then(function () {
                    defer.resolve();
                    $cookies.remove('authorization_token');
                    $rootScope.user = null;
                    $rootScope.meta = null;
                })
                .catch(function (response) {
                    defer.reject(ResponseErrorSrv.getTitle(response));
                });
            return defer.promise;
        }
    };

});