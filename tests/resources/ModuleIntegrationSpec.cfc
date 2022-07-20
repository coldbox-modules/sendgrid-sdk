component extends="coldbox.system.testing.BaseTestCase" {

    function beforeAll() {
        super.beforeAll();

        getWireBox().autowire( this );

        getController().getModuleService().registerAndActivateModule( "sendgrid-sdk", "testingModuleRoot" );
    }

    /**
     * @beforeEach
     */
    function setupIntegrationTest() {
        setup();
    }

}
