component {

    property name="interceptorService" inject="coldbox:interceptorService";

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

    private function generateStateName( webhookEvent ) {
        return "onSendgridEvent" & normalizeEventName( webhookEvent.event );
    }

    private function normalizeEventName( eventName ) {
        return replace( eventName, "_", "", "ALL" );
    }

}
