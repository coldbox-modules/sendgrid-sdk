component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Validate", function() {
            beforeEach( function() {
                variables.sendGridClient = getInstance( "SendGridClient@sendgrid-sdk" );
            } );

            afterEach( function() {
                structDelete( variables, "sendGridClient" );
            } );

            /*
             * NOTE: This test suite will only execute once a valid SendGrid API key is
             * added to the ColdBox.cfc config file AND the API key has access to the
             * email validation functionality
             *
            it( "can validate an email address", function() {
                var res = sendGridClient.validate(
                    email = "info@ortussolutions.com",
                    source = "test source"
                ).send();

                expect( res.getStatusCode() ).toBe( 200, "Response should be a 200 Ok" );

                expect( res.json().result.email ).toInclude( "info@ortussolutions.com" );
                expect( res.json().result.source ).toInclude( "test source" );
            } );
            */
        } );
    }

}
