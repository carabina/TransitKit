//
//  Line.swift
//  Transit
//
//  Created by Amornchai Kanokpullwad on 3/5/2559 BE.
//  Copyright © 2559 zoonref. All rights reserved.
//

import UIKit

/**
 *  Base protocol line for all type of animation transition
 */
protocol Line {
    
    /**
     Duration of the animation transition
     
     - returns: time interval of the transition this line will be used
     */
    func duration() -> NSTimeInterval
}

/**
 *  Protocol for transition that use `UIView` animation block
 */
protocol AnimationLine: Line {
    
    /**
     This function will be called to animate views for transition
     
     - parameter fromView:  view of view controller that going to disappear
     - parameter toView:    view of view controller that going to appear
     - parameter inView:    container view for transition
     - parameter direction: whether the transition direction is going or returning
     */
    func animate(fromView: UIView, toView: UIView, inView: UIView, direction: Direction)
    
    /**
     This function will be called to animate subviews if exists
     
     - parameter view:        subview that will be animated
     - parameter targetFrame: frame of the same subview name in destination view controller
     - parameter direction:   direction of the transition
     */
    func animatePassenger(view: UIView, targetFrame: CGRect, direction: Direction)
}

/**
 *  Protocol for transition that use `CADisplayLink` to animate
 */
protocol ProgressLine: Line {
    
    /**
     This function will be called to animate views for transition
     
     - parameter fromView:  view of view controller that going to disappear
     - parameter toView:    view of view controller that going to appear
     - parameter inView:    container view for transition
     - parameter direction: whether the transition direction is going or returning
     - parameter progress:  progress of the animation value between `0.0 - 1.0`
     */
    func progress(fromView: UIView, toView: UIView, inView: UIView, direction: Direction, progress: CGFloat)
    
    /**
     This function will be called to animate subviews if exists
     
     - parameter view:      subview that will be animated
     - parameter fromFrame: current initial frame of subview
     - parameter toFrame:   frame of the same subview name in destination view controller
     - parameter direction: direction of the transition
     - parameter progress:  progress of the animation value between `0.0 - 1.0`
     */
    func progressPassenger(view: UIView, fromFrame: CGRect, toFrame: CGRect, direction: Direction, progress: CGFloat)
}

/**
 *  Protocol for interactive transition
 */
protocol InteractionLine: Line {
    
    /**
     This function will be called to update views for interactive transition
     
     - parameter fromView: view of view controller that going to disappear
     - parameter toView:   view of view controller that going to appear
     - parameter inView:   container view for transition
     - parameter progress: progress of the animation value between (can be minus or > 1)
     */
    func interact(fromView: UIView, toView: UIView, inView: UIView, progress: CGFloat)
    
    /**
     This function will be called if interactive end and needs to animate to finish the transition
     
     - parameter fromView:     view of view controller that going to disappear
     - parameter toView:       view of view controller that going to appear
     - parameter inView:       container view for transition
     - parameter lastProgress: last progress when interaction ended
     - parameter velocity:     velocity that end interaction if provided
     
     - returns: custom animation time that this animation will use
     */
    func interactFinish(fromView: UIView, toView: UIView, inView: UIView,
                        lastProgress: CGFloat, velocity: CGPoint?) -> NSTimeInterval
    
    /**
     This function will be called if interactive end and needs to animate to cancel the transition
     
     - parameter fromView:     view of view controller that going to disappear
     - parameter toView:       view of view controller that going to appear
     - parameter inView:       container view for transition
     - parameter lastProgress: last progress when interaction ended
     - parameter velocity:     velocity that end interaction if provided
     
     - returns: custom animation time that this animation will use
     */
    func interactCancel(fromView: UIView, toView: UIView, inView: UIView,
                        lastProgress: CGFloat, velocity: CGPoint?) -> NSTimeInterval
    
    /**
     This function will be called to update subviews for interactive transition
     
     - parameter view:      subview that will be updated
     - parameter fromFrame: current initial frame of subview
     - parameter toFrame:   frame of the same subview name in destination view controller
     - parameter progress:  progress of the interaction
     */
    func interactPassenger(view: UIView, fromFrame: CGRect, toFrame: CGRect, progress: CGFloat)
    
    /**
     This function will be called if interactive end and needs to animate subviews to finish the transition
     
     - parameter view:     subview that will be animated
     - parameter toFrame:  destination frame
     - parameter duration: duration that animation should use (duration from `interactFinish`)
     */
    func interactPassengerFinish(view: UIView, toFrame: CGRect, duration: NSTimeInterval)
    
    /**
     This function will be called if interactive end and needs to animate subviews to cancel the transition
     
     - parameter view:     subview that will be animated
     - parameter toFrame:  destination frame
     - parameter duration: duration that animation should use (duration from `interactCancel`)
     */
    func interactPassengerCancel(view: UIView, toFrame: CGRect, duration: NSTimeInterval)
}