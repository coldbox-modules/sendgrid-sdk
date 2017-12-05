component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Module Activation", function() {
            it( "can run integration specs with the module activated", function() {
                expect( getController().getModuleService().isModuleRegistered( "sendgrid-sdk" ) ).toBeTrue();
            } );
        } );
    }

}
