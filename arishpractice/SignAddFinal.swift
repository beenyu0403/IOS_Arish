//
//  SignAddFinal.swift
//  arishpractice
//
//  Created by user on 2023/06/27.
//

import UIKit

class SignAddFinal: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInPageView") else {return}
        nextVC.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
        nextVC.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}
