//
//  ViewController.swift
//  UIDynamicAnimator
//
//  Created by Іван Штурхаль on 22.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var pushBehavior = UIPushBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createGestureRecognazier()
        createSmallSquareView()
        createAnimationAndBehaviors()
    }
    //створюємо квадрат
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView.backgroundColor = UIColor.green
        squareView.center = view.center
        view.addSubview(squareView )
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
        let collusion = UICollisionBehavior(items: [squareView])
        collusion.translatesReferenceBoundsIntoBoundary = true
        pushBehavior = UIPushBehavior(items: [squareView], mode: .continuous)
        animator.addBehavior(collusion)
        animator.addBehavior(pushBehavior)
    }
    @objc func handler(paramTap: UIGestureRecognizer) {
        // отримаємо кут view
        let tapPoint: CGPoint = paramTap.location(in: view)
        let squareViewCenterPoint: CGPoint = squareView.center
        let deltaX: CGFloat = tapPoint.x - squareViewCenterPoint.x
        let deltaY: CGFloat = tapPoint.y - squareViewCenterPoint.y
        let angle: CGFloat = atan2(deltaY, deltaX)
        pushBehavior.angle = angle
        
        let distanceBehavior: CGFloat = sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) + pow(tapPoint.y - squareViewCenterPoint.y, 2.0))
        pushBehavior.magnitude = distanceBehavior / 200
    }
}
