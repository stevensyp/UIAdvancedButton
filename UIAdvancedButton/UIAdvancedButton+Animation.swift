//
//  UIAdvancedButton+Animation.swift
//  UIAdvancedButton
//  by Steven Syp
//

import UIKit

extension UIAdvancedButton {
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        _animator.stopAnimation(false)
        _animator.finishAnimation(at: .current)
        _animator.addAnimations {
            self.alpha = 0.8
            if self.isAnimatedWhenPressed {
                self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }
        }

        _animator.startAnimation()
        return true
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        _animator.stopAnimation(false)
        _animator.finishAnimation(at: .current)
        _animator.addAnimations {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        _animator.startAnimation()
    }
}
