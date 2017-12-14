import UIKit

class ChatRoomViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var bottomView: ChatRoomInputView! //画面下部に表示するテキストフィールドと送信ボタン
	
	var chats: [ChatEntity] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	override var inputAccessoryView: UIView? {
		return bottomView //通常はテキストフィールドのプロパティに設定しますが、画面を表示している間は常に表示したいため、ViewControllerのプロパティに設定します
	}
}

extension ChatRoomViewController {
	func setupUI() {
		self.view.backgroundColor = UIColor(red: 113/255, green: 148/255, blue: 194/255, alpha: 1)
		tableView.backgroundColor = UIColor(red: 113/255, green: 148/255, blue: 194/255, alpha: 1)
		
		tableView.separatorColor = UIColor.clear // セルを区切る線を見えなくする
		tableView.estimatedRowHeight = 10000 // セルが高さ以上になった場合バインバインという動きをするが、それを防ぐために大きな値を設定
		tableView.rowHeight = UITableViewAutomaticDimension // Contentに合わせたセルの高さに設定
		tableView.allowsSelection = false // 選択を不可にする
		tableView.keyboardDismissMode = .interactive // テーブルビューをキーボードをまたぐように下にスワイプした時にキーボードを閉じる
		
		tableView.register(UINib(nibName: "YourChatViewCell", bundle: nil), forCellReuseIdentifier: "YourChat")
		tableView.register(UINib(nibName: "MyChatViewCell", bundle: nil), forCellReuseIdentifier: "MyChat")
		
		self.bottomView = ChatRoomInputView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)) // 下部に表示するテキストフィールドを設定
		let chat1 = ChatEntity(text: "text1", time: "10:01", userType: .I)
		let chat2 = ChatEntity(text: "text2", time: "10:02", userType: .You)
		let chat3 = ChatEntity(text: "text3", time: "10:03", userType: .I)
		chats = [chat1, chat2, chat3]
		
	}
}

extension ChatRoomViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.chats.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let chat = self.chats[indexPath.row]
		if chat.isMyChat() {
			let cell = tableView.dequeueReusableCell(withIdentifier: "MyChat") as! MyChatViewCell
			cell.clipsToBounds = true //bound外のものを表示しない
			// Todo: isRead
			cell.updateCell(text: chat.text, time: chat.time, isRead: true)
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "YourChat") as! YourChatViewCell
			cell.clipsToBounds = true
			cell.updateCell(text: chat.text, time: chat.time)
			return cell
		}
	}
}

extension ChatRoomViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(indexPath)
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 10
	}
}
