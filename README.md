# motion-inAppMail [![Gem Version](https://badge.fury.io/rb/motion-inappmail.png)](http://badge.fury.io/rb/motion-inappmail) [![Code Climate](https://codeclimate.com/github/Swatto/motion-inappmail.png)](https://codeclimate.com/github/Swatto/motion-inappmail)

A simple wrapper to use MFMailComposeViewController in a simple rubish way :

```ruby
InAppMail.compose(self,
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
    if callback.sent?
        p "Email sent"
    elsif callback.canceled?
        p "Email canceled"
    elsif callback.saved?
        p "Email saved in draft"
    elsif callback.failed?
        p "Error : #{callback.error}"
    end
end
```

## Adding Attachments
```ruby
fileData = NSData.dataWithContentsOfFile(someFilePath)

InAppMail.compose(self,
    {
        to: ["contact@example.com","contact2@example.com"],
        cc: ["foo@bar.com"],
        cci: ["bar@foo.com"],
        subject: "Hi everyone !",
        message: {
            html: true,
            body: "<h1>Hi from my super iOS app !</h1>"
        },
        attachments: [{data:fileData, mimeType:'text/plain', fileName: 'someFile.txt'}]
    }) do |callback|
    if callback.sent?
        p "Email sent"
    elsif callback.canceled?
        p "Email canceled"
    elsif callback.saved?
        p "Email saved in draft"
    elsif callback.failed?
        p "Error : #{callback.error}"
    end
end
```


## Usage

* The first params is the view or the view controller. It's needed to push it as a modal (needed).
* The second params is the options of your mail (secondary).
* The third is your callback block (secondary).
