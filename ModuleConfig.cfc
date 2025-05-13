component {

    this.name = "sendgrid-sdk";
    this.author = "Ortus Solutions";
    this.webUrl = "https://github.com/coldbox-modules/sendgrid-sdk";
    this.entrypoint = "/sendgrid";
    this.dependencies = [ "hyper" ];

    function configure() {
        settings = {
            "emailValidationAPIKey": getSystemSetting( "SENDGRID_SDK_EMAIL_VALIDATION_API_KEY", "" )
        };

        routes = [ { pattern: "/webhooks", handler: "webhooks", action: "handle" } ];

        interceptorSettings = {
            customInterceptionPoints: [
                "onSendgridEventProcessed",
                "onSendgridEventDropped",
                "onSendgridEventDelivered",
                "onSendgridEventDeferred",
                "onSendgridEventBounce",
                "onSendgridEventOpen",
                "onSendgridEventClick",
                "onSendgridEventSpamreport",
                "onSendgridEventUnsubscribe",
                "onSendgridEventGroupUnsubscribe",
                "onSendgridEventGroupResubscribe"
            ]
        };
    }

    function onLoad() {
		binder.map( "SendGridHyperClient@sendgrid-sdk" )
			.to( "hyper.models.HyperBuilder" )
			.asSingleton()
			.initWith(
				baseURL = "https://api.sendgrid.com"
			);
	}

}
