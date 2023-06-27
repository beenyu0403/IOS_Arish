//
//  SignAddPage.swift
//  arishpractice
//
//  Created by user on 2023/06/25.
//

import UIKit

var emailid:String = ""
var nameid:String = ""
var pw:String = ""


// 이메일 형식 검사
func emailFormat(_ emailtext: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailtext)
}
    

// 키보드 done 다음으로 넘어가기
extension SignAddPage: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            if nameTextField.text != "" {
                nameImageView.image = #imageLiteral(resourceName: "그룹 270")
                self.emailTextField.becomeFirstResponder()
            }else{
                nameImageView.image = #imageLiteral(resourceName: "그룹 271")
            }
        } else if textField == self.emailTextField {
            self.emailTextField.resignFirstResponder()
        }

        return true
        
    }
    // 만약 빈문자열이면 리턴키 동작안하게 만들게 한다.
    // 다음 텍스트로 넘어가 빈문자열이 아니면 키보드 내려가게 하기
   
}

class SignAddPage: UIViewController {
    
    var nextstate:Bool = false
    var cuemail:String = ""
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var emailFailedLabel: UILabel!
    var emailState:Bool = false
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emCheckButton: UIButton!
    @IBOutlet weak var emailCorrectLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
        hideKeyboardWhenTappedAround()
        emailCorrectLabel.layer.isHidden = true
        emailFailedLabel.layer.isHidden = true
        emailTextField.delegate = self
        nameTextField.delegate = self
        nextstate = false

        // Do any additional setup after loading the view.
    }
    
    func updateNextButton(willActive: Bool) {
            
            if(willActive == true) {
                //다음 버튼 색 변경
                if !nameTextField.text!.isEmpty{
                    self.nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 2"), for: .normal)
                    //다음 페이지 연결
                    print("다음 버튼 활성화")
                }
           
            } else  {
                //다음 버튼 색 변경
                if nextstate == true {
                    nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 2"), for: .normal)
                    //다음 페이지 연결 해제
                    print("다음 버튼 활성화-2")
                }
         
            }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if nextButton.currentBackgroundImage == UIImage(named: "구성 요소 83 – 2") {
            emailid = emailTextField.text!
            nameid = nameTextField.text!
            print(emailid)
            newUser.name = nameid
            newUser.email = emailid
            guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SignAddPwpage") else { return }
            self.navigationController?.pushViewController(pushVC, animated: true)
            
        }
    }
    
    
    @IBAction func inputName(_ sender: UITextField) {
        let nn:String = nameTextField.text!
        if nn.isEmpty != true{
            nameImageView.image = #imageLiteral(resourceName: "그룹 270")
            updateNextButton(willActive: false)
        }else{
            nameImageView.image = #imageLiteral(resourceName: "그룹 271")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }
    }
    
    @IBAction func clickEmCheckButton(_ sender: UIButton) {
        if emCheckButton.currentBackgroundImage == UIImage(named: "Icon awesome-check-circle 1") && emailState == true {
            cuemail = emailTextField.text!
            //--emailCheck(email: cuemail)
            // --이메일 중복 검사
            if emailCheckresult == true {
                nextstate = true
                emailFailedLabel.layer.isHidden = true
                emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                updateNextButton(willActive: true)
            }else {
                emailFailedLabel.layer.isHidden = false
                nextstate = false
            }
            
        }else {
            emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle 1"), for: .normal)
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
            nextstate = false
        }
    }
    
    @IBAction func inputEmail(_ sender: UITextField) {
        let ema:String = emailTextField.text!
        
        if emailFormat(ema) == true {
            emailState = true
            emailCorrectLabel.layer.isHidden = true
            emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle 1"), for: .normal)
            emailImageView.image = #imageLiteral(resourceName: "그룹 270")
            emailFailedLabel.layer.isHidden = true
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
            if emailCheck(email: ema) == true {
                emailCheckresult = true
            }else{
                emailCheckresult = false
            }
        }else if ema.isEmpty != true{
            emailState = false
            emailCorrectLabel.layer.isHidden = false
            emCheckButton.setBackgroundImage(UIImage(named: "icon-navigation-close_24px"), for: .normal)
            emailImageView.image = #imageLiteral(resourceName: "그룹 271")
            emailFailedLabel.layer.isHidden = true
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }else{
            emailState = false
            emailCorrectLabel.layer.isHidden = true
            emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle 1"), for: .normal)
            //emCheckButton.isSelected = false
            emailImageView.image = #imageLiteral(resourceName: "그룹 270")
            emailFailedLabel.layer.isHidden = true
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }
    }
    
    
}
