import UIKit

class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let viewControllers: [UIViewController]
    private let transitionDuration: Double = 0.2
    
    init(viewControllers: [UIViewController]?) {
        guard let controllers = viewControllers else { fatalError("Couldn't find viewControllers in MyTransition") }
        self.viewControllers = controllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        let quarterFrame = frame.width * 0.25
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - quarterFrame : frame.origin.x + quarterFrame
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + quarterFrame : frame.origin.x - quarterFrame
        toView.frame = toFrameStart
        
        let toCoverView = fromView.snapshotView(afterScreenUpdates: false)
        if let toCoverView = toCoverView {
            toView.addSubview(toCoverView)
        }
        let fromCoverView = toView.snapshotView(afterScreenUpdates: false)
        if let fromCoverView = fromCoverView {
            fromView.addSubview(fromCoverView)
        }
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [.curveEaseOut], animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
                toCoverView?.alpha = 0
                fromCoverView?.alpha = 1
            }) { (success) in
                fromCoverView?.removeFromSuperview()
                toCoverView?.removeFromSuperview()
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            }
        }
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        for (index, thisVC) in viewControllers.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
