reactorApp.factory('ResponseErrorSrv', function() {

    var unknownServerErrorMessage = 'Unknown server error'

    function validateJsonApiSchema(response) {
        return angular.isDefined(response.data)
            && angular.isDefined(response.data.errors)
            && angular.isArray(response.data.errors)
            && response.data.errors.length;
    }

    return {
        getTitle: function (response) {
            if (!validateJsonApiSchema(response)) {
                return unknownServerErrorMessage;
            }
            else {
                return response.data.errors.map(function (error) {
                    return error.title;
                })
            }
        }

    };
});