//
//  ViewController.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-12.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var binaryTextField: CustomTextField!
    @IBOutlet weak var octalTextField: CustomTextField!
    @IBOutlet weak var decimalTextField: CustomTextField!
    @IBOutlet weak var hexTextField: CustomTextField!
    
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
        self.configureTextFields()
    }

    // TODO: remove unnecessary zeros
    // TODO: set maximum bounds for the specific bases, i.e fix overflow issues
    // TODO: add additional zeros to binary numbers eg: triplets and quadruplets
    // TODO: refactor(rename some of the vars)
    // FIXME: fix navigationItem title disappearing sometimes

    private func configure(){
        binaryTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.octalTextField.text = self.binary.binaryToOctalFractional(binary: self.binaryTextField.text ?? "")
            self.decimalTextField.text = self.decimal.convertToDecimalFractional(fromBase: .binary, regexBase: .binary, number: self.binaryTextField.text ?? "")
            self.hexTextField.text = self.binary.binaryToHexFractional(binary: self.binaryTextField.text ?? "")
            }).disposed(by: disposeBag)
        
        octalTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.binaryTextField.text = self.octal.octalToBinaryFractional(octal: self.octalTextField.text ?? "")
            self.decimalTextField.text = self.decimal.convertToDecimalFractional(fromBase: .octal, regexBase: .octal, number: self.octalTextField.text ?? "")
            self.hexTextField.text = self.octal.octalToHexFractional(octal: self.octalTextField.text ?? "")
        }).disposed(by: disposeBag)
        
        decimalTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.binaryTextField.text = Decimal().convertFromDecimalFractional(toBase: .binary, number: self.decimalTextField.text ?? "")
            self.octalTextField.text = Decimal().convertFromDecimalFractional(toBase: .octal, number: self.decimalTextField.text ?? "")
            self.hexTextField.text = Decimal().convertFromDecimalFractional(toBase: .hex, number: self.decimalTextField.text ?? "")
        }).disposed(by: disposeBag)
        
        hexTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe({
            [unowned self] _ in
            self.binaryTextField.text = self.hex.hexToBinaryFractional(hex: self.hexTextField.text ?? "")
            self.octalTextField.text = self.hex.hexToOctalFractional(hex: self.hexTextField.text ?? "")
            self.decimalTextField.text = self.decimal.convertToDecimalFractional(fromBase: .hex, regexBase: .hex, number: self.hexTextField.text ?? "")
        }).disposed(by: disposeBag)
    }
}

// MARK: - Custom textField delegate
extension ViewController: UITextFieldDelegate {
    private func configureTextFields() {
        self.binaryTextField.delegate = self
        self.binaryTextField.maxLength = 24
        self.binaryTextField.valueType = .binary
        
        self.octalTextField.delegate = self
        self.octalTextField.maxLength = 24
        self.octalTextField.valueType = .octal
        
        self.decimalTextField.delegate = self
        self.decimalTextField.maxLength = 24
        self.decimalTextField.valueType = .decimal
        
        self.hexTextField.delegate = self
        self.hexTextField.maxLength = 24
        self.hexTextField.valueType = .hex
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Verify all the conditions
        if let customTextField = textField as? CustomTextField {
            return customTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
        }
        return false
    }
}

// MARK: - Dynamic keyboard view
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
