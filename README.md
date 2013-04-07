# motion-inAppMail

A simple wrapper to use MFMailComposeViewController in a simple rubish way :

```ruby
InAppMail.create(self,
	{
	    to: ["contact@example.com","contact2@example.com"],
	    cc: ["foo@bar.com"],
	    cci: ["bar@foo.com"],
	    subject: "Hi everyone !",
		message: {
			html: true,
			body: "<h1>Hi from my super iOS app !</h1>"
		}
    }) do |callback|
    if callback[:result] == MFMailComposeResultSent
        p "email sent"
    else
        p "Result: #{callback[:result]} & error: #{callback[:error]}"
    end
end
```

## Usage

* The first params is the view or the view controller. It's needed to push it as a modal.
* The second params is the options of your mail.
* The third is your callback block. To verifiy the state of the mail, you can use the constant :
	* For the result
		* MFMailComposeResultCancelled
		* MFMailComposeResultSaved
		* MFMailComposeResultSent
		* MFMailComposeResultFailed
	* For the error
		* MFMailComposeErrorDomain
		* MFMailComposeErrorCodeSaveFailed
		* MFMailComposeErrorCodeSendFailed