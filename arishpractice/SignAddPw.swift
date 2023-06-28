//
//  SignAddPw.swift
//  arishpractice
//
//  Created by user on 2023/06/27.
//

import UIKit
import Firebase

// 비밀번호 형식 검사
func PasswordFormat(pwdtext: String) -> Bool {
    let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: pwdtext)
}

// 비밀번호 같은지 검사
func isSameBothTextField(_ first: UITextField,_ second: UITextField) -> Bool {
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
}

extension SignAddPw: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.pwTextField {
            if pwTextField.text != "" {
                pwImageView.image = #imageLiteral(resourceName: "그룹 270")
                pwCorrectLabel.layer.isHidden = true
                self.pwsecondTextField.becomeFirstResponder()
            }else{
                pwImageView.image = #imageLiteral(resourceName: "그룹 271")
                pwCorrectLabel.layer.isHidden = false
            }
        } else if textField == self.pwsecondTextField {
            self.pwsecondTextField.resignFirstResponder()
        }

        return true
        
    }
    // 만약 빈문자열이면 리턴키 동작안하게 만들게 한다.
    // 다음 텍스트로 넘어가 빈문자열이 아니면 키보드 내려가게 하기
   
}

class SignAddPw: UIViewController {
    
    
    @IBOutlet weak var pwSecretButton: UIButton!
    @IBOutlet weak var pwSecondSecretButton: UIButton!
    
    var pwState:Bool = false
    var pwSameState:Bool = false
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pwCorrectLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    @IBOutlet weak var pwImageView: UIImageView!
    @IBOutlet weak var pwsecondImageView: UIImageView!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwsecondTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
        hideKeyboardWhenTappedAround()
        pwCorrectLabel.layer.isHidden = true
        pwCheckLabel.layer.isHidden = true
        pwTextField.delegate = self
        pwsecondTextField.delegate = self
        pwTextField.isSecureTextEntry = true
        pwsecondTextField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    func updateNextButton(willActive: Bool) {
            
            if(willActive == true) {
                //다음 버튼 색 변경
                if pwSameState == true {
                    nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 2"), for: .normal)
                    //다음 페이지 연결
                    print("다음 버튼 활성화")
                }
           
            } else  {
                //다음 버튼 색 변경
                if pwState == true {
                    nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 2"), for: .normal)
                    //다음 페이지 연결 해제
                    print("다음 버튼 활성화-2")
                }
         
            }
    }
   

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if nextButton.currentBackgroundImage == UIImage(named: "구성 요소 83 – 2") {
            pw = pwTextField.text!
            newUser.password = pw
            print(newUser.password)
            Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (user, error) in
                    if user !=  nil{
                        print("register success")
                        return
                    }
                    else{
                        print("register failed")
                        return
                    }
               
            }
            
            db.collection("USER").document(newUser.email).setData([
                "email": newUser.email,
                "name": newUser.name,
                "pw": newUser.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignAddFinalPage") else {return}
            nextVC.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
            nextVC.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                    self.present(nextVC, animated: true, completion: nil)
        
            
        }
    }
    
    
    @IBAction func pwButtonTapped(_ sender: UIButton) {
        if pwTextField.isSecureTextEntry == true {
            pwTextField.isSecureTextEntry = false
            pwSecretButton.setBackgroundImage(UIImage(named: "구성 요소 91 – 1"), for: .normal)
        } else {
            pwTextField.isSecureTextEntry = true
            pwSecretButton.setBackgroundImage(UIImage(named: "마스크 그룹 5"), for: .normal)
        }
            
    }
    
    @IBAction func pwSecondButtonTapped(_ sender: UIButton) {
        if pwsecondTextField.isSecureTextEntry == true {
            pwSecondSecretButton.setBackgroundImage(UIImage(named: "구성 요소 91 – 1"), for: .normal)
            pwsecondTextField.isSecureTextEntry = false
        }else{
            pwSecondSecretButton.setBackgroundImage(UIImage(named: "마스크 그룹 5"), for: .normal)
            pwsecondTextField.isSecureTextEntry = true
        }
    }
    
   
    @IBAction func inputPw(_ sender: UITextField) {
        let pw:String = pwTextField.text!
        if pwSameState == true {
            pwSameState = false
            pwCheckLabel.layer.isHidden = false
            pwsecondImageView.image = #imageLiteral(resourceName: "그룹 271")
        }
        if PasswordFormat(pwdtext: pw) == true {
            pwState = true
            pwCorrectLabel.layer.isHidden = true
            pwImageView.image = #imageLiteral(resourceName: "그룹 270")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
            updateNextButton(willActive: true)
        }else if pw.isEmpty != true{
            pwState = false
            pwCorrectLabel.layer.isHidden = false
            //emCheckButton.setBackgroundImage(UIImage(named: "icon-navigation-close_24px"), for: .normal)
            pwImageView.image = #imageLiteral(resourceName: "그룹 271")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }else{
            pwState = false
            pwCorrectLabel.layer.isHidden = true
            //emCheckButton.setBackgroundImage(UIImage(named: "Icon awesome-check-circle 1"), for: .normal)
            //emCheckButton.isSelected = false
            pwImageView.image = #imageLiteral(resourceName: "그룹 270")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }
    }
    
    @IBAction func inputPwSecond(_ sender: UITextField) {
        let pwsecond:String = pwsecondTextField.text!
        if isSameBothTextField(pwTextField, pwsecondTextField) == true {
            pwSameState = true
            pwCheckLabel.layer.isHidden = true
            pwsecondImageView.image = #imageLiteral(resourceName: "그룹 270")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
            updateNextButton(willActive: false)
        }else if pwsecond.isEmpty != true{
            pwSameState = false
            pwCheckLabel.layer.isHidden = false
            pwsecondImageView.image = #imageLiteral(resourceName: "그룹 271")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }else{
            pwSameState = false
            pwCheckLabel.layer.isHidden = true
            pwsecondImageView.image = #imageLiteral(resourceName: "그룹 270")
            nextButton.setBackgroundImage(UIImage(named: "구성 요소 83 – 1"), for: .normal)
        }
        
    }
    
    
    
    
}
