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
        self.view.backgroundColor = UIColor.whiteColor

        @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
        @action.setTitle('Email', forState:UIControlStateNormal)
        @action.frame = [[20, view.frame.size.width/2], [view.frame.size.width - 40, 40]]
        @action.addTarget(self, action:'createMail', forControlEvents:UIControlEventTouchUpInside)
        self.view.addSubview(@action)
    end

    def createMail
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
    end
end