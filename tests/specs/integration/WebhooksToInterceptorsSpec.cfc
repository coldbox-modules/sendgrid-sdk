component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    property name="interceptorService" inject="coldbox:interceptorService";

    function beforeAll() {
        super.beforeAll();
        interceptorService.registerInterceptor(
            interceptorObject = this
        );
    }

    function run() {
        describe( "Webhooks to Interceptors", function() {
            it( "converts webhooks to interceptors", function() {
                variables.interceptionExecutions = [];

                prepareMock( getRequestContext() )
                    .$( "getHTTPBasicCredentials", { "username" = "foo", "password" = "bar" } )
                    .$( "getHTTPContent" )
                    .$args( json = true )
                    .$results( deserializeJSON(
                        fileRead( expandPath( "/tests/resources/stubs/request-1.json" ) )
                    ) );

                expect( variables.interceptionExecutions ).toBeEmpty();
                var event = execute( route = "/sendgrid/webhooks", renderResults = true );
                var interceptionExecutionNames = arrayMap( variables.interceptionExecutions, function( execution ) {
                    return execution.name;
                } );
                expect( interceptionExecutionNames ).toBe( [
                    "onSendgridEventProcessed",
                    "onSendgridEventDeferred",
                    "onSendgridEventDelivered",
                    "onSendgridEventOpen",
                    "onSendgridEventClick",
                    "onSendgridEventBounce",
                    "onSendgridEventDropped",
                    "onSendgridEventSpamreport",
                    "onSendgridEventUnsubscribe",
                    "onSendgridEventGroupUnsubscribe",
                    "onSendgridEventGroupResubscribe"
                ] );
            } );

            it( "fails if basic auth credentials are configured in the application but not provided in the request", function() {
                variables.interceptionExecutions = [];

                prepareMock( getRequestContext() )
                    .$( "getHTTPContent" )
                    .$args( json = true )
                    .$results( deserializeJSON(
                        fileRead( expandPath( "/tests/resources/stubs/request-1.json" ) )
                    ) );

                expect( variables.interceptionExecutions ).toBeEmpty();
                var event = execute( route = "/sendgrid/webhooks", renderResults = true );
                var interceptionExecutionNames = arrayMap( variables.interceptionExecutions, function( execution ) {
                    return execution.name;
                } );
                expect( interceptionExecutionNames ).toBe( [] );
            } );
        } );
    }

    function onSendgridEventProcessed( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventProcessed",
            payload = interceptData
        } );
    }
    function onSendgridEventDeferred( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventDeferred",
            payload = interceptData
        } );
    }
    function onSendgridEventDelivered( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventDelivered",
            payload = interceptData
        } );
    }
    function onSendgridEventOpen( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventOpen",
            payload = interceptData
        } );
    }
    function onSendgridEventClick( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventClick",
            payload = interceptData
        } );
    }
    function onSendgridEventBounce( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventBounce",
            payload = interceptData
        } );
    }
    function onSendgridEventDropped( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventDropped",
            payload = interceptData
        } );
    }
    function onSendgridEventSpamreport( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventSpamreport",
            payload = interceptData
        } );
    }
    function onSendgridEventUnsubscribe( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventUnsubscribe",
            payload = interceptData
        } );
    }
    function onSendgridEventGroupUnsubscribe( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventGroupUnsubscribe",
            payload = interceptData
        } );
    }
    function onSendgridEventGroupResubscribe( event, interceptData, buffer, rc, prc ) {
        arrayAppend( variables.interceptionExecutions, {
            name = "onSendgridEventGroupResubscribe",
            payload = interceptData
        } );
    }

}
