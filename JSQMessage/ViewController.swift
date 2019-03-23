import UIKit
import Firebase
import JSQMessagesViewController



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    @IBOutlet weak var tableView: UITableView!
    var refreshControll: UIRefreshControl!

    var randomNumberArray = [Int]()
    //リフレッシュされた時のkeysの中身が全て格納されている。
    var userKeys2 = [String]()
    //選ばれたkeyが入っている。
    var displayedUserKeys = [String]()
    //表示されるユーザーの情報を入れる。
    var displayedUserInfo = [String]()
    //登録されたユーザー数
    var numberOfUsers2:Int?
    //作成されたルームキー
    var roomKey:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        /*self.refreshControll = UIRefreshControl()
        refreshControll.attributedTitle = NSAttributedString(string: "検索中")
        refreshControll.addTarget(self, action:Selector("refresh"), for: UIControl.Event.valueChanged)
 */
        
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedUserInfo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = self.displayedUserInfo[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         1.ルームの作成&そのkeyを取っておく
         2.相手のkeyも取得
         */
        self.roomKey = ref.child("Room").childByAutoId().key
        
        
        
        let chatViewController: ChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "chat") as! ChatViewController
        chatViewController.roomKey2 = self.roomKey
        chatViewController.friendKey = self.displayedUserKeys[indexPath.row]
        
        /*chatViewController.chatsenderID = id2
        chatViewController.chatsenderDisplayName = name2*/
    self.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    
    @IBAction func refresh(_ sender: Any) {
 
        //1
        ref.child("Keys").observeSingleEvent(of: .value) { (DataSnapshot) in
            let keys = DataSnapshot.value as? [String]
            self.userKeys2 = keys!
            //2
            for _ in 0..<10 {
                let arrayRundomNumber = Int.random(in: 0..<self.userKeys2.count)
                //self.displayedUserKeys.append(self.userKeys2[arrayRundomNumber])
                if mykey == self.userKeys2[arrayRundomNumber] {
                    self.userKeys2.remove(at: arrayRundomNumber)
                }
                self.ref.child("Users/\(self.userKeys2[arrayRundomNumber])").observeSingleEvent(of: .value) { (DataSnapshot) in
                    let userInfoDic = DataSnapshot.value as? Dictionary<String, String>
                    let userName = userInfoDic!["displayName"]
                    self.displayedUserInfo.append(userName!)

                }
                let userKey = self.userKeys2[arrayRundomNumber]
                self.displayedUserKeys.append(userKey)
                self.userKeys2.remove(at: arrayRundomNumber)
        }
            //after
            self.userKeys2.removeAll()
            print(self.displayedUserInfo)
            }
        
        }
   
    @IBAction func reloadData(_ sender: Any) {
        //3
        self.tableView.reloadData()
        //4

    }
}


