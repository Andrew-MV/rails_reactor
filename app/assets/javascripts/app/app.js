var reactorApp = angular.module('reactorApp', ['ngRoute', 'templates']);

reactorApp
    .config(function($routeProvider, $locationProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'homepage.html'
            })
            .otherwise({
                templateUrl: '404.html'
            })

        // configure html5 to get links working on jsfiddle
        $locationProvider.html5Mode({
            enabled: true
        });

    });