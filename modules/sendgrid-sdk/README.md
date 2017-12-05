# sendgrid-sdk

[![Master Branch Build Status](https://img.shields.io/travis/coldbox-modules/sendgrid-sdk/master.svg?style=flat-square&label=master)](https://travis-ci.org/coldbox-modules/sendgrid-sdk)

## An API for interacting with SendGrid, including sending emails and receiving webhooks

### Webhooks

Easily listen to webhooks using this module. Simply point Sendgrid to
`https://<your-server>/sendgrid/webhooks` and this module will translate all
Sendgrid events to ColdBox interceptors.

The following are the interceptors that are created and the Sendgrid event they
correspond with:

* `onSendgridEventProcessed` => `processed`
* `onSendgridEventDropped` => `dropped`
* `onSendgridEventDelivered` => `delivered`
* `onSendgridEventDeferred` => `deferred`
* `onSendgridEventBounce` => `bounce`
* `onSendgridEventOpen` => `open`
* `onSendgridEventClick` => `click`
* `onSendgridEventSpamreport` => `spamreport`
* `onSendgridEventUnsubscribe` => `unsubscribe`
* `onSendgridEventGroupUnsubscribe` => `group_unsubscribe`
* `onSendgridEventGroupResubscribe` => `group_resubscribe`

The `interceptData` is the data sent from Sendgrid.
