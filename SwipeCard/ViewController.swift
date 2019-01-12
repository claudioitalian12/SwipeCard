//
//  ViewController.swift
//  SwipeCard
//
//  Created by claudio Cavalli on 12/01/2019.
//  Copyright © 2019 claudio Cavalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenSize = UIScreen.main.bounds
    var divisionParam: CGFloat!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisionParam = (view.frame.size.width/2)/0.61

        numberOfCard(view: view, number: 10)
        
    }

    
    
    func numberOfCard(view: UIView, number: Int){
        
        for _ in 1...number{
            
            let card = UIView()
            card.frame = CGRect(x: screenSize.maxX / 2 , y: screenSize.maxY / 10, width: screenSize.width / 1.5, height: screenSize.height / 2)
            card.layer.cornerRadius = 8
            card.center = view.center
            card.transform = .identity
            card.backgroundColor = .random()
            let panGesture = UIPanGestureRecognizer(target: self, action:#selector(self.panGestureCard(_:)))
            
            card.addGestureRecognizer(panGesture)
            view.addSubview(card)
        }
        
    }

    
 @objc func panGestureCard(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        
        let distanceMoved = cardView.center.x - view.center.x
      
    
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
        
        if sender.state == UIGestureRecognizer.State.ended {
            if cardView.center.x < 20 { // Moved to left
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x-self.screenSize.width/1.5, y: cardView.center.y)
                })
                return
            }
            else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+self.screenSize.width/1.5, y: cardView.center.y)
                })
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                cardView.center = self.view.center
                cardView.transform = .identity
            })
        }

    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
