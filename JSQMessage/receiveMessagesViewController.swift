import UIKit
import Firebase
import JSQMessagesViewController


class receiveMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var messages:[JSQMessage] = []
    var roomKeyArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        ref.child("Post\(mykey))").observe(.value) { (DataSnapshot) in
            guard let dic = DataSnapshot.value as? Dictionary<String, AnyObject> else {
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
                        let roomKey = value["key"] as! String
                        preMessages.append(JSQMessage(senderId: senderId, displayName: displayName, text: text))
                        self.roomKeyArray.append(roomKey)
                        
                    }
                }
            }
            self.messages = preMessages
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! CustomCellController

        cell.nameTextLabel.text = messages[indexPath.row].senderDisplayName
        cell.textTextLabel.text = messages[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "showchatViewController", sender: nil)
        let selectedRoomKey = roomKeyArray[indexPath.row]
        let chat2ViewController: chat2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "chat2") as! chat2ViewController
        chat2ViewController.roomkey = selectedRoomKey
        self.navigationController?.pushViewController(chat2ViewController, animated: true)
    }
    
    
    
    
}


