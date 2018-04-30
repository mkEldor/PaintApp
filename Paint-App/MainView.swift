//
//  MainView.swift
//  Paint-App
//
//  Created by Eldor Makkambaev on 30.04.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import UIKit

class MainView: UIView {
    var shapes: [Shape] = []
    var tempShape: [Shape] = []
    
    var first_point: CGPoint!
    var second_point: CGPoint!
    
    var path: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        for shape in shapes {
            path = shape.getPath(shape.key!)
            
            shape.color!.set()
            if shape.isFill!{
                path?.fill()
            }
            path?.stroke()
        }
        if !Shape.isPen {
            for shape in tempShape{
                let path = shape.getPath(shape.key!)
                
                shape.color!.set()
                if shape.isFill!{
                    path.fill()
                }
                path.stroke()
            }
            tempShape = []
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if Shape.isPen{
            second_point = touches.first?.location(in: self)
            shapes.append(Shape(first_point!, second_point!,
                                key: ViewController.key,
                                color: ViewController.color, isFill: ViewController.isFill))
            first_point = second_point
            setNeedsDisplay()
        } else {
            second_point = touches.first?.location(in: self)
            tempShape.append(Shape(first_point!, second_point, key: ViewController.key,
                                   color: ViewController.color, isFill: ViewController.isFill));
            setNeedsDisplay()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        first_point = touches.first?.location(in: self)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        second_point = touches.first?.location(in: self)
        shapes.append(Shape(first_point!, second_point, key: ViewController.key,
                            color: ViewController.color, isFill: ViewController.isFill));
        setNeedsDisplay()
    }
    
    func deleteLast(){
        if !shapes.isEmpty {
            shapes.removeLast()
            setNeedsDisplay()
        }
    }
    func deleteAll(){
        shapes = []
        tempShape = []
        setNeedsDisplay()
    }
}

