# sendgrid-sdk

[![Master Branch Build Status](https://img.shields.io/travis/coldbox-modules/sendgrid-sdk/master.svg?style=flat-square&label=master)](https://travis-ci.org/coldbox-modules/sendgrid-sdk)

## An API for interacting with SendGrid, including sending emails, validating email addresses, and receiving webhooks

### Email Validation

Leverage the SendGrid API to validate email addresses.  SendGrid will provide
a validation result, score, and test results to help you determine the validity
of an email address.

#### Setup

Configure your SendGrid API key credentials in the `config/ColdBox.cfc` file.

Note: SendGrid uses a Bearer API token header for authentication with their API.
The SendGrid API Keys can have different permissions granted and email address
validation is typically seperate from all other permission sets.


```
moduleSettings = {
    "sendgrid-sdk" = {
        emailValidationAPIKey = ""
    }
};
```

#### Methods

##### validate

Validate the provided email address. Returns a configured `HyperRequest` instance.

| Name           | Type          | Required? | Default | Description                                                                      |
| -------------- | ------------- | --------- | ------- | -------------------------------------------------------------------------------- |
| email          | String        | `true`    |         | The email address to validate                                                    |
| source         | String        | `false`   |         | An optional text string that identifies the source of the email address          |



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

#### Basic Authentication

SendGrid supports basic authentication when calling your webhook.
To set this up, provide a `username` and `password` in your `moduleSettings`:

```
moduleSettings = {
    "sendgrid-sdk" = {
        "username" = "foo",
        "password" = "bar"
    }
};
```

Note: if you only a username or a password, `sendgrid-sdk` will return a 500 error.