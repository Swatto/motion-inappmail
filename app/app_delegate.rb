class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @navigationController = UINavigationController.alloc.initWithRootViewController(TestViewController.alloc.init)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @navigationController
    @window.makeKeyAndVisible
    true
  end
end

class TestViewController < UIViewController
    def viewDidLoad
        super
        self.view.backgroundColor = UIColor.lightGrayColor
        self.title = "InAppMail example"

        @actionWithoutArg = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        @actionWithoutArg.setTitle('Email without options and callback', forState:UIControlStateNormal)
        @actionWithoutArg.frame = [[20, 40], [view.frame.size.width - 40, 40]]
        @actionWithoutArg.addTarget(self, action: :createMailWithoutArg, forControlEvents:UIControlEventTouchUpInside)
        self.view.addSubview(@actionWithoutArg)

        @actionWithArg = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        @actionWithArg.setTitle('Email with options for construction', forState:UIControlStateNormal)
        @actionWithArg.frame = [[20, 100], [view.frame.size.width - 40, 40]]
        @actionWithArg.addTarget(self, action: :createMailWithArg, forControlEvents:UIControlEventTouchUpInside)
        self.view.addSubview(@actionWithArg)

        @actionWithCallback = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        @actionWithCallback.setTitle('Email with callback', forState:UIControlStateNormal)
        @actionWithCallback.frame = [[20, 160], [view.frame.size.width - 40, 40]]
        @actionWithCallback.addTarget(self, action: :createMailWithCallback, forControlEvents:UIControlEventTouchUpInside)
        self.view.addSubview(@actionWithCallback)

        @actionWithArgAndCallback = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        @actionWithArgAndCallback.setTitle('Email with options and callback', forState:UIControlStateNormal)
        @actionWithArgAndCallback.frame = [[20, 220], [view.frame.size.width - 40, 40]]
        @actionWithArgAndCallback.addTarget(self, action: :createMailWithArgAndCallback, forControlEvents:UIControlEventTouchUpInside)
        self.view.addSubview(@actionWithArgAndCallback)
    end

    def createMailWithoutArg
        InAppMail.compose(self)
    end

    def createMailWithArg
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
            })
    end

    def createMailWithCallback
        InAppMail.compose(self) do |callback|
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
    end

    def createMailWithArgAndCallback
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
    end
end