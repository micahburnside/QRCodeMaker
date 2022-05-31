//
//  QRCodeGeneratorViewController.swift
//  QRCodeGenerator
//
//  Created by Micah Burnside on 5/29/22.
//

import UIKit

class QRCodeGeneratorViewController: BaseViewController {
    
    let navigationBarItem = UINavigationBar()
    @IBOutlet weak var urlTextFieldOutlet: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var generateQRCodeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextFieldOutlet.setLeftPadding(value: 16)
        self.hideKeyboardWhenTappedAround()
    
    }

    @IBAction func generateQRCodePressed(_ sender: UIButton) {
        
        let url = urlTextFieldOutlet.text
        if let urlText = url {
            let combinedString = "\(urlText)\n\(Date())"
            imageView.image = generateQRCode(Name: combinedString)
        }
    }

    
    func generateQRCode(Name:String) -> UIImage? {
        let nameData = Name.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(nameData, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

}

extension UITextField {


    func setLeftPadding(value: Int) {

        self.leftView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: value, height: value)))
        self.leftViewMode = .always
    }

    func setRightPadding(value: Int) {

        self.rightView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: value, height: value)))
        self.rightViewMode = .always
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

