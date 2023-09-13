//
//  ViewController.swift
//  UIDynamicAnimator
//
//  Created by Іван Штурхаль on 22.05.2023.
//



import UIKit

class ViewController: UIViewController {
    
    var circleView = UIView()
    var anotherCircle = UIView()
    var animator = UIDynamicAnimator()
    var pushBehavior = UIPushBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createGestureRecognazier()
        createCircleViews()
        createAnimationAndBehaviors()
    }
    //створюємо квадрат
    func createCircleViews() {
        circleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        circleView.layer.cornerRadius = 40
        circleView.backgroundColor = UIColor.blue
        circleView.center = view.center
        view.addSubview(circleView)
    }
    //додаємо жест
    func createGestureRecognazier() {
        let tapGestureRecognazier = UITapGestureRecognizer(target: self, action: #selector(handler))
        view.addGestureRecognizer(tapGestureRecognazier)
    }
    //створюємо зіткнення
    func createAnimationAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        //створюємо зіткнення
        let collusion = UICollisionBehavior(items: [circleView])
        collusion.translatesReferenceBoundsIntoBoundary = true
        pushBehavior = UIPushBehavior(items: [circleView], mode: .continuous)
        animator.addBehavior(collusion)
        animator.addBehavior(pushBehavior)
    }
    @objc func handler(paramTap: UIGestureRecognizer) {
        // отримаємо кут view
        let tapPoint: CGPoint = paramTap.location(in: view)
        let circleViewCenterPoint: CGPoint = circleView.center
        let deltaX: CGFloat = tapPoint.x - circleViewCenterPoint.x
        let deltaY: CGFloat = tapPoint.y - circleViewCenterPoint.y
        let angle: CGFloat = atan2(deltaY, deltaX)
        pushBehavior.angle = angle
        let distanceBehavior: CGFloat = sqrt(pow(tapPoint.x - circleViewCenterPoint.x, 2.0) + pow(tapPoint.y - circleViewCenterPoint.y, 2.0))
        pushBehavior.magnitude = distanceBehavior / 200
        
    }
}
