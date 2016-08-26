var reactorApp = angular.module('reactorApp', ['ngRoute', 'templates', 'cgNotify','ngCookies']);

reactorApp
    .config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'homepage.html',
                controller: 'HomePageCtrl',
                resolve: {
                    isUserAuthorized: function($q, $rootScope, AuthorizationSrv) {
                        var defer = $q.defer();

                        AuthorizationSrv
                            .verifyToken()
                            .then(function(user) {
                                $rootScope.user = user;
                                defer.resolve(true);
                            })
                            .catch(function() {
                                defer.resolve(false);
                            })
                    }
                }
            })
            .otherwise({
                templateUrl: '404.html'
            })

        // configure html5 to get links working on jsfiddle
        $locationProvider.html5Mode({
            enabled: true
        });

        $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content');
        $httpProvider.defaults.headers.post['Content-Type'] = 'application/vnd.api+json'

    });