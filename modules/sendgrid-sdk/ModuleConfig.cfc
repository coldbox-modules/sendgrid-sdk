component {

    this.name = "sendgrid-sdk";
    this.author = "Ortus Solutions";
    this.webUrl = "https://github.com/coldbox-modules/sendgrid-sdk";
    this.entrypoint = "/sendgrid";

    function configure() {
        routes = [ { pattern = "/webhooks", handler = "webhooks", action = "handle" } ];

        interceptorSettings = {
            customInterceptionPoints = [
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

}
