//
//  SignAddViewModel.swift
//  arishpractice
//
//  Created by user on 2023/06/27.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct User {
    var name: String
    var email: String
    var password: String
}
var newUser : User = User(name: "", email: "", password: "")

var firestore: Firestore!
let db = Firestore.firestore()
var emailCheckresult:Bool = false
/*
 이메일 중복 검사
 */
func emailCheck(email: String) -> Bool {
    //var result:Bool = false
    
    let userDB = db.collection("USER")
    // 입력한 이메일이 있는지 확인 쿼리
    let query = userDB.whereField("email", isEqualTo: email)

    query.getDocuments { (qs, err) in
        
        if qs!.documents.isEmpty {
            print("데이터 중복 안 됨 가입 진행 가능")
            emailCheckresult = true
            return
        } else {
            print("데이터 중복 됨 가입 진행 불가")
            emailCheckresult = false
            return
        }
    }
    return emailCheckresult
}


