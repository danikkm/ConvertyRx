//
//  ViewController.swift
//  ConvertyRx
//
//  Created by Daniel Dluzhnevsky on 2020-08-12.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var binaryTextField: UITextField!
    @IBOutlet weak var octalTextField: UITextField!
    @IBOutlet weak var decimalTextField: UITextField!
    @IBOutlet weak var hexTextField: UITextField!
    
    private let binary = Binary()
    private let octal = Octal()
    private let decimal = Decimal()
    private let hex = Hex()
    
    static func instantiate() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Converty"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsWhenKeyboardAppears = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()
        self.configure()
    }

    // TODO: combine binary hex functions into one
    // TODO: add additional zeros to binary numbers eg: triplets and quadruplets
    // FIXME:  replace some if statements with iflet?

    private func configure(){
        binaryTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.octalTextField.text = self.binary.binaryToOctalFractional(binary: self.binaryTextField.text ?? "")
            self.decimalTextField.text = self.binary.binaryToDecimalFractional(binary: self.binaryTextField.text ?? "")
            self.hexTextField.text = self.binary.binaryToHexFractional(binary: self.binaryTextField.text ?? "")
            }).disposed(by: disposeBag)
        
        octalTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.binaryTextField.text = self.octal.octalToBinaryFractional(octal: self.octalTextField.text ?? "")
            self.decimalTextField.text = self.octal.octalToDecimalFractional(octal: self.octalTextField.text ?? "")
            self.hexTextField.text = self.octal.octalToHexFractional(octal: self.octalTextField.text ?? "")
        }).disposed(by: disposeBag)
        
        decimalTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.binaryTextField.text = self.decimal.decimalToBinaryFractional(inputDecimal: self.decimalTextField.text ?? "")
            self.octalTextField.text = self.decimal.decimalToOctalFractional(inputDecimal: self.decimalTextField.text ?? "")
            self.hexTextField.text = self.decimal.decimalToHexFractional(inputDecimal: self.decimalTextField.text ?? "")
        }).disposed(by: disposeBag)
        
        hexTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.binaryTextField.text = self.hex.hexToBinaryFractional(hex: self.hexTextField.text ?? "")
            self.octalTextField.text = self.hex.hexToOctalFractional(hex: self.hexTextField.text ?? "")
            self.decimalTextField.text = self.hex.hexToDecimalFractional(hex: self.hexTextField.text ?? "")
        }).disposed(by: disposeBag)
    }
}

extension ViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 196
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
