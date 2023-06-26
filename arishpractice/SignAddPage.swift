//
//  SignAddPage.swift
//  arishpractice
//
//  Created by user on 2023/06/25.
//

import UIKit



func emailFormat(_ emailtext: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailtext)
}
    
// 비밀번호 형식 검사
func PasswordFormat(pwdtext: String) -> Bool {
    let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: pwdtext)
}

class SignAddPage: UIViewController {
    
    
    
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emCheckButton: UIButton!
    @IBOutlet weak var emailCorrectLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
        hideKeyboardWhenTappedAround()
        emailCorrectLabel.layer.isHidden = true
       

        // Do any additional setup after loading the view.
    }
    
    //화면 다른 부분 클릭 시 키보드 내리기
    //override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
      //  self.view.endEditing(true)
    //
    //}
  
    
    @IBAction func inputEmail(_ sender: UITextField) {
        let ema:String = emailTextField.text!
        
        if emailFormat(ema) == true {
            emailCorrectLabel.layer.isHidden = true
            emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle 1"), for: .normal)
            //emCheckButton.isSelected = true
            emailImageView.image = #imageLiteral(resourceName: "그룹 270")
            
        }else if ema.isEmpty != true{
            emailCorrectLabel.layer.isHidden = false
            emCheckButton.setBackgroundImage(UIImage(named: "icon-navigation-close_24px"), for: .normal)
            emailImageView.image = #imageLiteral(resourceName: "그룹 271")
        }else{
            emailCorrectLabel.layer.isHidden = true
            emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle 1"), for: .normal)
            //emCheckButton.isSelected = false
            emailImageView.image = #imageLiteral(resourceName: "그룹 270")
        }
    }
    
    
}
