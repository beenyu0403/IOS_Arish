//
//  SignInPage.swift
//  arishpractice
//
//  Created by user on 2023/06/27.
//

import UIKit
import Firebase

// 키보드 done 다음으로 넘어가기
extension SignInPage: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.idTextField {
            if idTextField.text != "" {
                idImageView.image = #imageLiteral(resourceName: "그룹 270")
                self.pwTextField.becomeFirstResponder()
            }else{
                idImageView.image = #imageLiteral(resourceName: "그룹 271")
            }
        } else if textField == self.pwTextField {
            self.pwTextField.resignFirstResponder()
        }
        return true
    }
    // 만약 빈문자열이면 리턴키 동작안하게 만들게 한다.
    // 다음 텍스트로 넘어가 빈문자열이 아니면 키보드 내려가게 하기
   
}


class SignInPage: UIViewController {
    
    
    
    
    
    @IBOutlet weak var pwImageView: UIImageView!
    @IBOutlet weak var idImageView: UIImageView!
    @IBOutlet weak var idAndPwLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idAndPwLabel.layer.isHidden = true
        setKeyboardObserver()
        hideKeyboardWhenTappedAround()
        idTextField.delegate = self
        pwTextField.delegate = self
        
    }
    
    
    // 로그인 성공 시 홈 화면으로
    func loginSuccess() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "homeView") else {return}
        nextVC.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        nextVC.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(nextVC, animated: true, completion: nil)
    }
    
   
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let loginid = idTextField.text!
        let loginpw = pwTextField.text!
        //var pwCheckresult:Bool = false
        let userDB = db.collection("USER")
        userDB.document(loginid).addSnapshotListener { (qs, err) in
                guard let document = qs else {
                    print("Error: \(err!)")
                    return
                }
                let message = document.get("pw") as? String ?? ""
                if message == loginpw {
                    //pwCheckresult = true
                    print("비밀번호가 일치합니다.")
                    Auth.auth().signIn(withEmail: loginid, password: loginpw) { (user, error) in
                        if user != nil{
                            print("login success")
                            self.loginSuccess()
                        }
                        else{
                            print("login fail")
                            print("Error: \(error!)")
                        }
                    }
                }else{
                    //pwCheckresult = false
                    print("비밀번호가 다릅니다.")
            }
           
        }
   
    }
    
    
    @IBAction func findIdOrPwButtonTapped(_ sender: UIButton) {
        guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "FindIdOrPwPageView") else { return }
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
}
