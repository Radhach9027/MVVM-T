@testable import MVVM_C
import XCTest

class TravellerTests: XCTestCase {

    var mockNavigation = NavigationControllerMock(navigation: UINavigationController(rootViewController: UIViewController()))
    var mockStoryBoard = StroyBoardMock()
    var mockViewController = ViewControllerMock()
    var mockWindow = WindowMock()
    var mockWayFinding: WayFinding?
    
    override func setUp() {
        super.setUp()
        let mockWayFinding = WayFinding(navigation: mockNavigation, viewController: mockViewController, storyBoard: mockStoryBoard)
        Traveller.shared.config(wayFinding: mockWayFinding)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testNavigationAttributes_ShouldReturnExpectedAttributes_NotNil() {
        XCTAssertNotNil(mockNavigation.navigationController)
        XCTAssertNotNil(mockNavigation.topViewController)
        XCTAssertNotNil(mockNavigation.visibleViewController)
    }
    
    func testPush_ShouldReutrnExpectedViewController() {
        let expectation = XCTestExpectation(description: "W8 for controller to get pushed")
        let controller = Traveller.route.push(story: .login, controller: .login, animated: true, modelTransistion: .crossDissolve, modelPresentation: .none).perform { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.modalTransitionStyle, mockNavigation.mockPushViewController?.modalTransitionStyle)
        XCTAssertEqual(controller?.modalPresentationStyle, mockNavigation.mockPushViewController?.modalPresentationStyle)
        XCTAssertEqual(controller, mockNavigation.mockPushViewController)
    }
    
    func testPresent_ShouldReutrnExpectedViewController() {
        let expectation = XCTestExpectation(description: "W8 for controller to get presented")
        let controller = Traveller.route.present(story: .login, controller: .login, animated: true, modelTransistion: .crossDissolve, modelPresentation: .overCurrentContext).perform { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.modalTransitionStyle, mockViewController.mockPresentedViewController?.modalTransitionStyle)
        XCTAssertEqual(controller?.modalPresentationStyle, mockViewController.mockPresentedViewController?.modalPresentationStyle)
        XCTAssertEqual(controller, mockViewController.mockPresentedViewController)
    }
    
    func testAddChildViewController_ShouldRetrunExpectedViewController() {
        let expectation = XCTestExpectation(description: "W8 for controller to get added as child")
        let controller = Traveller.route.addChild(childController: .login, storyDestination: .login, modelTransistionStyle: .crossDissolve).perform { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(controller)
        if let childController = self.mockViewController.children.first {
            XCTAssertEqual(controller, childController)
            XCTAssertEqual(controller?.modalTransitionStyle, childController.modalTransitionStyle)
        }
    }
    
    func testPopViewController_ShouldRetrunIncrementValue() {
        Traveller.route.pop(toRootController: false, animated: true, modelTransistionStyle: .crossDissolve).perform()
        XCTAssertEqual(mockNavigation.mockPopViewControllerTriggered, 1)
    }

    func testPopToRootViewController_ShouldRetrunIncrementValue() {
        Traveller.route.pop(toRootController: true, animated: true, modelTransistionStyle: .crossDissolve).perform()
        XCTAssertEqual(mockNavigation.mockPopToRootViewControllerTriggered, 1)
    }
    
    func testPopToViewController_ShouldRetrunExpectedViewController() {
        let expectation = XCTestExpectation(description: "W8 for controller to get return respective controller")
        let controllerOne = UIViewController()
        controllerOne.accessibilityLabel = "MockOne"
        let controllerTwo = UIViewController()
        controllerTwo.accessibilityLabel = "MockTwo"
        let mockChildControllers = [controllerOne, controllerTwo]
        self.mockNavigation.setViewControllers(mockChildControllers, animated: false)
        XCTAssertEqual(mockChildControllers, self.mockNavigation.viewControllers)
        let controller = Traveller.route.popToViewController(destination: UIViewController.self, animated: false, modelTransistionStyle: .crossDissolve).perform { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(controller)
        XCTAssertEqual(controllerOne.accessibilityLabel, controller?.accessibilityLabel)
        XCTAssertEqual(controllerOne.modalTransitionStyle, controller?.modalTransitionStyle)
    }
    
    func testDismissViewController_ShouldRetrunExpectedViewController() {
        Traveller.route.dismiss(modelTransistionStyle: .crossDissolve, animated: true).perform()
        XCTAssertEqual(mockViewController.mockDismissTriggered, 1)
        XCTAssertEqual(UIModalTransitionStyle.crossDissolve, mockViewController.modalTransitionStyle)
    }
    
    func testRemoveChildViewController_ShouldRemoveExpectedViewController() {
        Traveller.route.removeChild.perform()
        XCTAssertEqual(mockViewController.mockRemoveChildTriggered, 1)
    }
    
    func testNavigationStack_ShouldReturnExpectedViewController() {
        let controllerOne = UIViewController()
        controllerOne.accessibilityLabel = "MockOne"
        let controllerTwo = UIViewController()
        controllerTwo.accessibilityLabel = "MockTwo"
        let mockChildControllers = [controllerOne, controllerTwo]
        self.mockNavigation.setViewControllers(mockChildControllers, animated: false)
        XCTAssertEqual(mockChildControllers, self.mockNavigation.viewControllers)
    }
    
    func testSwitchingWindowRootView_ShouldReturnExpectedRootViewController() {
        Traveller.route.switchRootViewController(storyBoard: self.mockStoryBoard, controllerDestination: .login, animated: false, window: self.mockWindow, modelTransistion: .transitionCrossDissolve).perform()
        XCTAssertNotNil(self.mockWindow.rootViewController)
        XCTAssertEqual(self.mockWindow.mockKeyAndVisible, 1)
    }
    
    func testPerformSegue_ShouldReturnExpectedViewContorller() {
    }
    
    func testUnWindSegue_ShouldReturnExpectedViewContorller() {
    }
}
