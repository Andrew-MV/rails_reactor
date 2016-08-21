reactorApp.factory('NotifierSrv', function(notify) {

    return {
        error: function(message) {
            notify({
                message: message,
                classes: 'cg-notify-message-error',
                position: 'right'
            });
        },

        success: function(message) {
            notify({
                message: message,
                position: 'right'
            });
        }
    };

});