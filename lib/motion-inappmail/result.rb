# ========================================================================
# InAppMail module created by Gaël Gillard (http://blog.gaelgillard.com)
# Use it, hack it, embed it in your project or whatever
# ========================================================================

module InAppMail

  # Result class for the callback block
  # ---------------------------------------
  # Access to information of the result with basic method

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
end