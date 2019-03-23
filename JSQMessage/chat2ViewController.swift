//
//  ViewController.swift
//  JSQMessage
//
//  Created by 廣瀬由明 on 2019/02/18.
//  Copyright © 2019 廣瀬由明. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class chat2ViewController: JSQMessagesViewController {
    var ref: DatabaseReference!
    
    var messages:[JSQMessage] = [
        JSQMessage(senderId: "005", displayName: "Dai", text: "こんにちは")
    ]
    
    var roomkey:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        senderDisplayName = myname
        senderId = myid
        ref.child("Room/\(self.roomkey)").observe(.value, with: { snapshot in
            guard let dic = snapshot.value as? Dictionary<String, AnyObject> else {
                return
            }
            guard let posts = dic["Messages"] as? Dictionary<String, Dictionary<String, AnyObject>> else {
                return
            }
            // keyとdateが入ったタプルを作る
            var keyValueArray: [(String, Int)] = []
            for (key, value) in posts {
                keyValueArray.append((key: key, date: value["date"] as! Int))
            }
            keyValueArray.sort{$0.1 < $1.1}             // タプルの中のdate でソートしてタプルの順番を揃える(配列で) これでkeyが順番通りになる
            // messagesを再構成
            var preMessages = [JSQMessage]()
            for sortedTuple in keyValueArray {
                for (key, value) in posts {
                    if key == sortedTuple.0 {           // 揃えた順番通りにメッセージを作成
                        let senderId = value["senderId"] as! String
                        let text = value["text"] as! String
                        let displayName = value["displayName"] as! String
                        preMessages.append(JSQMessage(senderId: senderId, displayName: displayName, text: text))
                    }
                }
            }
            self.messages = preMessages
            
            self.collectionView.reloadData()
        })
        
        //addNavBar()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        collectionView.frame =  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        return messages[indexPath.item]
    }
    //コメントの背景色の設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if messages[indexPath.item].senderId == senderId {
            return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor(red: 112/255, green: 192/255, blue: 75/255, alpha: 1))} else {
            return JSQMessagesBubbleImageFactory()?.incomingMessagesBubbleImage(with: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1))
        }
    }
    
    //コメントの文字の色の指定
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell  = super.collectionView(collectionView, cellForItemAt: indexPath) as!
        JSQMessagesCollectionViewCell
        if messages[indexPath.row].senderId == senderId {
            cell.textView.textColor = UIColor.white
        } else {
            cell.textView.textColor = UIColor.darkGray
        }
        return cell
    }
    
    //メッセージの数
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    //ユーザーアバターの設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        if messages[indexPath.item].senderId == senderId {
            //let myavatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: self.senderDisplayName, backgroundColor: UIColor.darkGray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 10), diameter: 30)
            return nil
        } else {
            let oppositavatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "O", backgroundColor: UIColor.green, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 10), diameter: 30)
            return oppositavatar
        }
    }
    
    //sendボタンが押された時の処理
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        ref.child("Room/\(self.roomkey)/").childByAutoId().setValue(["senderId": senderId, "text": text, "displayName": senderDisplayName, "date": ServerValue.timestamp()])
        
        
        finishSendingMessage()
        //\(String(describing: senderDisplayName))/
    }
    
    //メッセージの受信
    
    //戻るボタンの処理
    /*let viewController: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "back") as! ViewController
        
 self.navigationController?.popViewController(animated: true)*/

}
