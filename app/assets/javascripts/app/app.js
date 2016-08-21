var reactorApp = angular.module('reactorApp', ['ngRoute', 'templates', 'cgNotify']);

reactorApp
    .config(function($routeProvider, $locationProvider, $httpProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'homepage.html',
                controller: 'HomePageCtrl'
            })
            .otherwise({
                templateUrl: '404.html'
            })

        // configure html5 to get links working on jsfiddle
        $locationProvider.html5Mode({
            enabled: true
        });

        $httpProvider.defaults.headers.common['X-CSRF-Token'] = angular.element('meta[name=csrf-token]').attr('content');

    });