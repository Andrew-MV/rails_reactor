reactorApp.factory('NotifierSrv', function(notify) {

    return {
        
        error: function(message) {
            (angular.isArray(message) ? message : [message])
                .forEach(function(msg) {
                    notify({
                        message: msg,
                        classes: 'cg-notify-message-error',
                        position: 'right',
                        duration: 2000
                    });
                })
                
        },

        success: function(message) {
            (angular.isArray(message) ? message : [message])
                .forEach(function(msg) {
                    notify({
                        message: msg,
                        position: 'right',
                        duration: 2000
                    });
                })
        }
    };

});