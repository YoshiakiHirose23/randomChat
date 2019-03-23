//
//  startupViewController.swift
//  FirebaseCore
//
//  Created by 廣瀬由明 on 2019/02/22.
//

import UIKit
import Firebase
import JSQMessagesViewController

var myid:String?
var myname:String?
var mykey:String?

class startupViewController: UIViewController {

    var ref:DatabaseReference!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var senderIDTextFiled: UITextField!
    
    var userInfo = [String:String] ()
    var keys = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
        
    }

    @IBAction func signIN(_ sender: Any) {
        //displayNameとIDを登録＆receivedIDを作成
        myname = displayNameTextField.text
        myid = senderIDTextFiled.text
        self.userInfo["senderId"] = myid
        self.userInfo["displayName"] = myname
        let userRef = ref.child("Users")

        //自分に与えられたchildByautoIDのkeyを自分のプロフィール情報と、ランダムに選ぶためのSQL/Keysに入れる。
        if let myKey1 = userRef.childByAutoId().key {
            mykey = myKey1
            //Usersの方に入れる
            userRef.child(myKey1).setValue(userInfo)
            //配列を作り、自分のを入れて、保存する。そして破棄する。
            ref.child("Keys").observeSingleEvent(of: .value) { (DataSnapshot) in
                let keysArray = DataSnapshot.value as? [String]
                self.keys = keysArray!
                self.keys.append(myKey1)
                
                self.ref.child("Keys").setValue(self.keys)
                
            }
        }
    
        self.keys.removeAll()
        performSegue(withIdentifier: "next", sender: nil)
        
        
        
        
    //self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
