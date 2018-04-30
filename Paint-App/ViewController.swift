//
//  ViewController.swift
//  Paint-App
//
//  Created by Eldor Makkambaev on 30.04.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, colorDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    let shapesPickerView = UIPickerView()
    let shapes = [#imageLiteral(resourceName: "circle"), #imageLiteral(resourceName: "rectangle"), #imageLiteral(resourceName: "line"), #imageLiteral(resourceName: "triangle"), #imageLiteral(resourceName: "pen")]
    var rotationAngle: CGFloat!

    @IBAction func longUndoPressed(_ sender: UILongPressGestureRecognizer) {
        mainView.deleteAll()
    }
    
    static var color: UIColor = UIColor.black
    static var isFill: Bool = true
    
    @IBAction func switchFill(_ sender: UISwitch) {
        if sender.isOn {
            ViewController.isFill = true
        } else {
            ViewController.isFill = false
        }
    }
    
    @IBOutlet weak var fillSwitch: UISwitch!
    @IBOutlet weak var currentColor: UIButton!
    static var key = ShapeModel.circle
    static var operations: Dictionary<Int, ShapeModel> = [
        0: .circle,
        1: .rectangle,
        2: .line,
        3: .triangle,
        4: .pen
    ]
    @IBOutlet weak var pickerView: ColorPicker!
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var shapesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        shapesPickerView.delegate = self
        shapesPickerView.dataSource = self
        //pickerView rotation
        rotationAngle = -90 * (.pi/180)
        shapesPickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        //pickerview creation
        shapesPickerView.frame = CGRect(x: 0 , y: 0, width: shapesView.frame.width , height: 50)
        //shapesPickerView.center = self.shapesView.center
        shapesView.addSubview(shapesPickerView)
        
        
    }
    func pickedColor(color: UIColor) {
        currentColor.backgroundColor = color
        ViewController.color = color
    }
    
    @IBAction func undoPressed(_ sender: UIButton) {
        mainView.deleteLast()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shapes.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        image.image = shapes[row]
        view.addSubview(image)
        
        // view rotation
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return view
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        ViewController.key = ViewController.operations[row]!
    }
    
    
}

