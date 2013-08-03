# ========================================================================
# InAppMail module created by Gaël Gillard (http://blog.gaelgillard.com)
# Use it, hack it, embed it in your project or whatever
# ========================================================================

module InAppMail

  module_function

  # Base method to create your in app mail
  # ---------------------------------------
  # Arguments :
  # 1. The parent view or the view controller. Needed to push it as a modal
  # 2. The hash to construct the base of the mail (secondary)
  # 3. The callback block (secondary)
  
  def compose(delegate=nil,options=nil,&callback)
    if delegate
      @delegate = delegate
    else
      warn "[WARNING] InAppMail need a the current view or view controller as first argument."
      return true
    end

    @callback = callback if callback

    @mailController = MFMailComposeViewController.alloc.init
    @mailController.mailComposeDelegate = self

    if((options)&&(options.class == Hash))
      if((options[:to])&&(options[:to].class == Array))
        @mailController.setToRecipients(options[:to])
      end

      if((options[:cc])&&(options[:cc].class == Array))
        @mailController.setCcRecipients(options[:cc])
      end

      if((options[:cci])&&(options[:cci].class == Array))
        @mailController.setBccRecipients(options[:cci])
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

    if((options[:attachments])&&(options[:attachments].class == Hash))
      data = options[:attachments][:data]
      mimeType = options[:attachments][:mimeType]
      p "CLASS:"
      p data.class
      if((data && data.class == NSData)&&(mimeType && mimeType.class == String))
        @mailController.addAttachmentData(data, mimeType: mimeType)
      end
    end

    @delegate.presentModalViewController(@mailController, animated:true)
  end

  # [DEPRECATION] Old name of method to create your in app mail
  # -------------------------------------------------------------
  # Arguments : same as compose

  def create(delegate=nil,options=nil,&callback)
    warn "[DEPRECATION] `create` is deprecated for InAppMail. Use the compose method instead."
    self.compose(delegate,options,&callback)
  end

  # Event when the MFMailComposeViewController is closed
  # -------------------------------------------------------------
  # the callback is fired if it was present in the constructor

  def mailComposeController(controller, didFinishWithResult: result, error: error)
    @delegate.dismissModalViewControllerAnimated(true)
    @callback.call(Result.new(result,error)) if @callback
  end
end
