//
//  ViewController.swift
//  arishpractice
//
//  Created by user on 2023/01/19.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let backnavi = UIBarButtonItem()
        //backnavi.title = "회원가입"
        //self.navigationController?.navigationBar.topItem?.backBarButtonItem = backnavi
        self.navigationController?.navigationBar.tintColor = .black
    }
   

    // 이메일 가입 페이지
    var signEmail:String = ""
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInPageView") else { return }
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    
}

