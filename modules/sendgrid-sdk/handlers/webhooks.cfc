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
     * SendGrid Module Settings
     */
    property name="log" inject="logbox:logger:{this}";

    /**
     * Translate incoming webhooks to ColdBox interceptors
     */
    function handle( event, rc, prc ) {
        if ( needsAuth() ) {
            log.debug( "Authentication is set up for SendGrid SDK.  Checking credentials now" );
            if ( isPartialAuthCredentials() ) {
                log.warn( "Partial authentication detected for SendGrid SDK.", sendgridSettings );
                return event.renderData( statusCode = 500, data = "Invalid auth configuration" );
            }
            if ( isInvalidAuthCredentials( event ) ) {
                log.info( "Invalid incoming credentials detected for SendGrid webhook endpoint", {
                    "incomingCredentials": event.getHTTPBasicCredentials(),
                    "sendgridSettings": sendgridSettings
                } );
                return event.renderData( statusCode = 401, data = "Invalid credentials" );
            }
        }

        var webhookEvents = event.getHTTPContent( json = true );
        log.debug( "Converting incoming webhook events to interception points", webhookEvents );
        for ( var webhookEvent in webhookEvents ) {
            log.debug( "Announcing #generateStateName( webhookEvent )# SendGrid event", webhookEvent );
            interceptorService.processState(
                generateStateName( webhookEvent ),
                webhookEvent
            );
        }

        log.debug( "All events announced.  Returning 200 to SendGrid" );
        return event.renderData( statusCode = 200, data = "Successfully caught the webhook" );
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

    /**
     * Checks if basic authentication was only partially configured.
     *
     * @returns True if the authentication credentials are only partially configured.
     */
    private function isPartialAuthCredentials() {
        return ( structKeyExists( sendgridSettings, "username" ) && ! structKeyExists( sendgridSettings, "password" ) ) ||
             ( ! structKeyExists( sendgridSettings, "username" ) && structKeyExists( sendgridSettings, "password" ) );
    }

    /**
     * Checks if basic authentication is needed for the request.
     *
     * @returns True if the request needs authorization.
     */
    private function needsAuth() {
        return structKeyExists( sendgridSettings, "username" ) ||
            structKeyExists( sendgridSettings, "password" );
    }

    /**
     * Checks if the basic authentication credentials provided are valid.
     *
     * @event The ColdBox Request Context
     *
     * @returns True if the authentication credentials are invalid.
     */
    private function isInvalidAuthCredentials( event ) {
        var basicAuth = event.getHTTPBasicCredentials();
        return ( basicAuth.username != sendgridSettings.username ||
                basicAuth.password != sendgridSettings.password );
    }

}
