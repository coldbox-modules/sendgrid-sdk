/**
 * Interact with the SendGrid API
 */
component singleton accessors="true" {

	/**
	 * The configured SendGrid API Key for Email Validation
	 */
	property name="emailValidationAPIKey" inject="box:setting:emailValidationAPIKey@sendgrid-sdk";

	/**
	 * A configured HyperBuilder client to use with the SendGrid API. 
	 * This is handled for you when using as a ColdBox module.
	 */
	property name="hyperClient" inject="SendGridHyperClient@sendgrid-sdk";

	/**
	 * Validate an email address
	 *
	 * @email          The email address to validate
	 * @source	       An optional text string that identifies the source of the email address
	 *
	 * @returns        A configured HyperRequest instance.
	 */
	function validate( required string email, string source ) {

		var reqBody = { "email": arguments.email };
		if( structKeyExists( arguments, "source" ) && len( arguments.source ) ){
			reqBody[ "source" ] = arguments.source;
		}

		var req = newRequest()
			.setUrl( "/v3/validations/email" )
			.setMethod( "POST" )
			.withHeaders( { "Authorization": "Bearer #emailValidationAPIKey#" } )
			.setBody( reqBody );

		return req;
	}

	function newRequest() {
		return hyperClient.new();
	}

	function onMissingMethod( missingMethodName, missingMethodArguments ) {
		return invoke( newRequest(), missingMethodName, missingMethodArguments );
	}

}
