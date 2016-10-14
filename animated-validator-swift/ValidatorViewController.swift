//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var valid = false
    var errorText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        turnOffAutoResizing()
        setupConstraints()
        
        phoneTextField.keyboardType = .numberPad
        self.submitButton.isEnabled = false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateValue(textField)
        if  emailTextField.text != errorText &&
            emailConfirmationTextField.text != errorText &&
            phoneTextField.text != errorText &&
            passwordTextField.text != errorText &&
            passwordConfirmTextField.text != errorText {
            valid = true
        } else { valid = false }
        
        if valid { //animate submit button
            enableSubmit()
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !valid {
            textField.text = ""
            textField.backgroundColor = UIColor.clear }
    }
    
    
    func validateValue(_ textField: UITextField) {
        
        switch textField.tag {
        case 1, 2: //Email
            if (textField.text?.isEmpty)! {
                errorText = "Enter a value"
                valid = false
            } else if !(textField.text?.contains("@"))! {
                errorText = "Invalid email missing @"
                valid = false
            } else {
                valid = true
            }
            
        case 3: //Phone
            guard Int(textField.text!) != nil else {
                errorText = "Numbers only"
                valid = false
                break }
            
            if (textField.text?.characters.count)! < 7 {
                errorText = "Should be at least 7 digits"
                valid = false
            } else {
                //             let text = textField.text?.characters.
                valid = true
            }
            
        case 4, 5: //Password
            if (textField.text?.characters.count)! < 6 {
                errorText = "Should be at least 6 characters"
                valid = false
            }else {
                valid = true
            }
        default:
            break
        }
        
        if !valid{
            UITextField.animate(withDuration: 0.3, delay: 0.0, options: [.autoreverse], animations: {
                textField.backgroundColor = UIColor.red
                textField.text = self.errorText
                textField.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                textField.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil )
        }
    }
    
    func turnOffAutoResizing() {
            [emailTextField, emailConfirmationTextField, phoneTextField, passwordTextField, passwordConfirmTextField].forEach { textField in
                textField?.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(textField!)
            }
        
        
    }
    
    func setupConstraints() {
        
        emailTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        emailConfirmationTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        emailConfirmationTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        emailConfirmationTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
       
        phoneTextField.topAnchor.constraint(equalTo: emailConfirmationTextField.bottomAnchor, constant: 10).isActive = true
        phoneTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        phoneTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        passwordConfirmTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        passwordConfirmTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func enableSubmit() {
        UIButton.animate(withDuration: 0.8, animations: {
            self.submitButton.translatesAutoresizingMaskIntoConstraints = false
            self.submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
            self.submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.submitButton.isEnabled = true
            self.submitButton.center.x = self.view.center.x
            }, completion: nil)
    }
}

