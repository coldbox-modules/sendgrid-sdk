/**
 * Translate incoming webhooks to ColdBox interceptors
 */
component {

    /**
     * SendGrid Module Settings
     */
    property name="sendgridSettings" inject="coldbox:moduleSettings:sendgrid-sdk";

    /**
     * The ColdBox Interceptor Service
     */
    property name="interceptorService" inject="coldbox:interceptorService";

    /**
     * Translate incoming webhooks to ColdBox interceptors
     */
    function handle( event, rc, prc ) {
        if ( needsAuth() ) {
            if ( isPartialAuthCredentials() ) {
                return event.renderData( statusCode = 500, data = "Invalid auth configuration" );
            }
            if ( isInvalidAuthCredentials( event ) ) {
                return event.renderData( statusCode = 401, data = "Invalid credentials" );
            }
        }

        var webhookEvents = event.getHTTPContent( json = true );
        for ( var webhookEvent in webhookEvents ) {
            interceptorService.processState(
                generateStateName( webhookEvent ),
                webhookEvent
            );
        }

        return event.renderData( statusCode = 200, data = "" );
    }

    /**
     * Generate an interceptor state name from a Sendgrid event name.
     *
     * @webhookEvent The Sendgrid webhook event struct.
     *
     * @returns An interceptor state name.
     */
    private function generateStateName( webhookEvent ) {
        return "onSendgridEvent" & normalizeEventName( webhookEvent.event );
    }

    /**
     * Normalize a Sendgrid event name by removing any special characters.
     *
     * @webhookEvent The Sendgrid webhook event name.
     *
     * @returns A normalized Sendgrid webhook event name.
     */
    private function normalizeEventName( eventName ) {
        return replace( eventName, "_", "", "ALL" );
    }

    private function isPartialAuthCredentials() {
        return ( structKeyExists( sendgridSettings, "username" ) && ! structKeyExists( sendgridSettings, "password" ) ) ||
             ( ! structKeyExists( sendgridSettings, "username" ) && structKeyExists( sendgridSettings, "password" ) );
    }

    private function needsAuth() {
        return structKeyExists( sendgridSettings, "username" ) ||
            structKeyExists( sendgridSettings, "password" );
    }

    private function isInvalidAuthCredentials( event ) {
        var basicAuth = event.getHTTPBasicCredentials();
        return ( basicAuth.username != sendgridSettings.username ||
                basicAuth.password != sendgridSettings.password );
    }

}
