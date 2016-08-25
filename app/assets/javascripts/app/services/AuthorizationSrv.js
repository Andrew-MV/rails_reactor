reactorApp.factory('AuthorizationSrv', function($http, $q, $rootScope, $cookies, ResponseErrorSrv, ResponseSuccessSrv) {

    return {
        verifyToken: function() {
            var defer = $q.defer();
            $http.post('api/verify-token', {
                authorization_token: $cookies.get('authorization_token')
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
                login: login,
                password: password
            }).then(function (response) {
                $rootScope.user = ResponseSuccessSrv.getUser(response);
                $cookies.put('authorization_token', ResponseSuccessSrv.getMeta(response).authorization_token);
                defer.resolve(ResponseSuccessSrv.getMeta(response));
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
                $rootScope.user = ResponseSuccessSrv.getUser(response);
                $cookies.put('authorization_token', ResponseSuccessSrv.getMeta(response).authorization_token);
                defer.resolve(ResponseSuccessSrv.getUser(response));
            }).catch(function (response) {
                defer.reject(ResponseErrorSrv.getTitle(response));
            });
            return defer.promise;
        },

        logOut: function() {
            var defer = $q.defer();
            $http.post('api/log-out', { })
                .then(function () {
                    defer.resolve();
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