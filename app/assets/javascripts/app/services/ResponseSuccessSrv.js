reactorApp.factory('ResponseSuccessSrv', function() {

    var badResponseMessage = 'Bad response'

    function validateJsonApiSchema(response) {
        return angular.isDefined(response.data)
            // && angular.isDefined(response.data.data)
            && angular.isDefined(response.data.meta);
    }

    return {
        getUser: function (response) {
            if (!validateJsonApiSchema(response)) {
                return badResponseMessage;
            }
            else {
                return response.data.data;
            }
        },
        
        getMeta: function (response) {
            if (!validateJsonApiSchema(response)) {
                return badResponseMessage;
            }
            else {
                return response.data.meta;
            }
        }
    };
});