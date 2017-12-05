/**
 * Translate incoming webhooks to ColdBox interceptors
 */
component {

    /**
     * The ColdBox Interceptor Service
     */
    property name="interceptorService" inject="coldbox:interceptorService";

    /**
     * Translate incoming webhooks to ColdBox interceptors
     */
    function handle( event, rc, prc ) {
        var webhookEvents = event.getHTTPContent( json = true );
        for ( var webhookEvent in webhookEvents ) {
            interceptorService.processState(
                generateStateName( webhookEvent ),
                webhookEvent
            );
        }

        event.renderData( statusCode = 200, data = "" );
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

}
