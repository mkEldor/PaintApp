//
//  Models.swift
//  Paint-App
//
//  Created by Eldor Makkambaev on 30.04.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import Foundation
import UIKit


func getDouble(_ cgFloat: CGFloat) -> Double{
    return Double(cgFloat)
}

func getRadius(first_point: CGPoint, second_point: CGPoint) -> CGFloat {
    let distance = sqrt(Double(pow(getDouble(first_point.x - second_point.x), 2)) + Double(pow(first_point.y - second_point.y, 2)))
    return CGFloat(distance/2)
}
func getCenter(first_point: CGPoint, second_point: CGPoint) -> CGPoint {
    return CGPoint(x: CGFloat(((Double(first_point.x)) + Double(second_point.x))/2), y: CGFloat(((Double(first_point.y)) + Double(second_point.y))/2))
}
func getSize(_ first_point: CGPoint, _ second_point: CGPoint) -> CGSize {
    let width = second_point.x - first_point.x
    let height = second_point.y - first_point.y
    return CGSize(width: width, height: height)
}




class Shape {
    
    var first_point: CGPoint?
    var second_point: CGPoint?
    static var isPen: Bool = false
    var aPath = UIBezierPath()
    
    var shape: Shape?
    var key: ShapeModel?
    var color: UIColor?
    var isFill: Bool?
    
    init(_ first: CGPoint, _ second: CGPoint) {
        first_point = first
        second_point = second
    }
    
    init(_ first: CGPoint, _ second: CGPoint, key: ShapeModel, color: UIColor, isFill: Bool) {
        self.first_point = first
        self.second_point = second
        self.key = key
        self.color = color
        self.isFill = isFill
    }
    
    func getPath(_ key: ShapeModel) -> UIBezierPath {
        aPath = UIBezierPath()
        switch key {
        case .circle:
            Shape.isPen = false
            aPath.addArc(withCenter: getCenter(first_point: first_point!, second_point: second_point!),
                         radius: getRadius(first_point: first_point!, second_point: second_point!),
                         startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
            break
        case .rectangle:
            Shape.isPen = false
            let rect = CGRect(origin: first_point!, size: getSize(first_point!, second_point!))
            aPath = UIBezierPath(rect: rect)
            break
        case .line:
            Shape.isPen = false
            aPath.move(to: first_point!)
            aPath.addLine(to: second_point!)
            break
        case .triangle:
            Shape.isPen = false
            let path = UIBezierPath()
            path.move(to: first_point!)
            path.addLine(to: second_point!)
            path.addLine(to: CGPoint(x: first_point!.x, y: second_point!.y))
            path.close()
            
            /*aPath.move(to: first_point!)
             aPath.addLine(to: second_point!)
             aPath.move(to: first_point!)
             aPath.addLine(to: CGPoint(x: first_point!.x, y: second_point!.y))
             aPath.move(to: second_point!)
             aPath.addLine(to: CGPoint(x: first_point!.x, y: second_point!.y))*/
            
            aPath = path
            break
        case .pen:
            Shape.isPen = true
            aPath.move(to: first_point!)
            aPath.addLine(to: second_point!)
            break
        }
        aPath.stroke()
        //aPath.fill()
        return aPath
    }
}
enum ShapeModel{
    case circle
    case rectangle
    case line
    case triangle
    case pen
}
