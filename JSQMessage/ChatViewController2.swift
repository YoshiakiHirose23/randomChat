//
//  ChatViewController2.swift
//  FirebaseCore
//
//  Created by 廣瀬由明 on 2019/02/20.
//

import UIKit
import JSQMessagesViewController

class ChatViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

class ChatViewController: JSQMessagesViewController {
    var ref: DatabaseReference!
    
    var messages:[JSQMessage] = [
        JSQMessage(senderId: "005", displayName: "Yoshiaki", text: "こんにちは"),
        JSQMessage(senderId: "001", displayName: "Taro", text: "どうも")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        senderDisplayName = "Yoshiaki"
        senderId = "005"
        
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
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
            let myavatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: self.senderDisplayName, backgroundColor: UIColor.darkGray, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 10), diameter: 30)
            return myavatar
        } else {
            let oppositavatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "O", backgroundColor: UIColor.green, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 10), diameter: 30)
            return oppositavatar
        }
    }
    
    //sendボタンが押された時の処理
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message!)
        ref.child("Rooms/Room001/Message").setValue(message?.text)
        finishSendingMessage()
        //\(String(describing: senderDisplayName))/
    }
    
    //メッセージの受信
    
    //戻るボタンの処理
    
    
}

