//
//  Extensions.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

extension UIButton {
    func setCustomAtrributedTitle(firstPart: String, seccondPart: String){
        let attri: [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87) , .font: UIFont.systemFont(ofSize: 16)]
        let boldAttri: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor(white: 1, alpha: 0.87) , .font: UIFont.boldSystemFont(ofSize: 16) ]
        
        //NSMutableAttributedString is used to append another NSAttributedString
        let btnTitle = NSMutableAttributedString (string: firstPart, attributes: attri)
        btnTitle.append(NSAttributedString(string: seccondPart, attributes: boldAttri))
        
        // set NsMutableAttributesString to AtrributedTitle
        setAttributedTitle(btnTitle, for: .normal)
    }
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}


extension UIViewController {
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.systemPurple.cgColor , UIColor.systemBlue.cgColor]
       // gradient.locations = [0,1]

        view.layer.addSublayer(gradient)
        // We must set view frame to gradient frame
        gradient.frame = view.frame
    }
}


extension UserDefaults {
    func setIsloggedIn(_ value: Bool) {
        set(value, forKey: "isLoggedIn")
    }
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn") 
    }
}


class CustomTextField: UITextField {
    
    init(placeHolderName: String) {
        super.init(frame: .zero) // we are setting dynamically in the code
        
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        attributedPlaceholder = NSAttributedString(string: placeHolderName, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.6)])

        keyboardAppearance = .dark // set keyboard color
        
        let spaceLeftSide = UIView()
        spaceLeftSide.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spaceLeftSide.widthAnchor.constraint(equalToConstant: 12).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        // here leftView is The overlay view that displays on the left
        leftView = spaceLeftSide
        leftViewMode = .always //left overlay view appears in the text fiel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
