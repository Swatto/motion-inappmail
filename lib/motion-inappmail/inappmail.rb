module InAppMail

  class Result
    attr_accessor :result, :error

    def initialize(result, error)
      self.result = result
      self.error = error
    end

    def sended?
      if self.result == MFMailComposeResultSent
        true
      else
        false
      end
    end

    alias_method :sent?, :sended?

    def canceled?
      if self.result == MFMailComposeResultCancelled
        true
      else
        false
      end
    end

    def saved?
      if self.result == MFMailComposeResultSaved
        true
      else
        false
      end
    end

    def failed?
      if((self.result == MFMailComposeResultFailed)||(self.error))
        true
      end
    end
  end

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

    @delegate.presentModalViewController(@mailController, animated:true)
  end

  def mailComposeController(controller, didFinishWithResult: result, error: error)
    @delegate.dismissModalViewControllerAnimated(true)
    @callback.call Result.new(result,error)
  end
end