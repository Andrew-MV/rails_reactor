reactorApp.directive('authorizationFormDrv', function(AuthorizationSrv, NotifierSrv) {
    return {
        restrict: 'E',
        scope: {
            results: '='
        },
        templateUrl: 'authorization_form.html',
        link: function(scope, element, attrs) {
            scope.mode = {
                signup: false,
                signin: true
            };

            scope.switchMode = function() {
                scope.mode.signup = !scope.mode.signup;
                scope.mode.signin = !scope.mode.signin;
            };

            scope.signUp = function() {
                AuthorizationSrv
                    .signUp(scope.login, scope.password)
                    .then(function() {
                        NotifierSrv.success('Signed up')
                    })
                    .catch(function(message) {
                        NotifierSrv.error(message)
                    })
                    .finally(function() {
                    });
            };
            
            scope.signIn = function() {
                AuthorizationSrv
                    .signIn(scope.login, scope.password)
                    .then(function() {
                        NotifierSrv.success('Signed in')
                    })
                    .catch(function(message) {
                        NotifierSrv.error(message)
                    })
                    .finally(function() {
                    });
            };

        }
    };
})