module InAppMail
  module_function

  def create(delegate,options,&callback)
    @callback = callback
    @delegate = delegate

    @mailController = MFMailComposeViewController.alloc.init
    @mailController.mailComposeDelegate = self

    if((options)&&(options.class == Hash))
      if((options[:to])&&(options[:to].class == Array))
        @mailController.setToRecipients(options[:to])
      end

      if((options[:cc])&&(options[:cc].class == Array))
        @mailController.setCcRecipients(options[:cc])
      end

      if((options[:bcc])&&(options[:bcc].class == Array))
        @mailController.setBccRecipients(options[:bcc])
      end

      if((options[:subject])&&(options[:subject].class == String))
        @mailController.setSubject(options[:subject])
      else
        @mailController.setSubject("Contact")
      end

      if((options[:message])&&(options[:message].class == Hash))
        if(options[:message][:html])
          @isHtml = true
        else
          @isHtml = false
        end
        if((options[:message][:body])&&(options[:message][:body].class == String))
          @mailController.setMessageBody(options[:message][:body], isHTML: @isHtml)
        end
      end
    end

    @delegate.presentModalViewController(@mailController, animated:true)
  end

  def mailComposeController(controller, didFinishWithResult: result, error: error)
    @delegate.dismissModalViewControllerAnimated(true)
    @callback.call result: result, error: error
  end
end