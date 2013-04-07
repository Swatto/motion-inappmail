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
        InAppMail.create(self,{
            to: ["foo@bar.com"],
            subject: "Hi !"
            }) do |callback|
            if callback[:result] == MFMailComposeResultSent
                p "email sent"
            else
                p callback[:result]
            end
        end
    end
end