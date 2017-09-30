//
//  ViewController.swift
//  TodoList
//
//  Created by Dai Haneda on 2017/09/28.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var todoList = [MyTodo]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //保存データ読み込み
    let userdefaults = UserDefaults.standard
    
    if let saveData = userdefaults.object(forKey: "todoList") as? Data {
      if let unarchive = NSKeyedUnarchiver.unarchiveObject(with: saveData) as? [MyTodo] {
        todoList.append(contentsOf: unarchive)
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func addTodoButton(_ sender: Any) {
    //Todo追加ダイアログ表示
    let alert = UIAlertController(title: "Todo追加", message: "Todoを入力してください", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addTextField(configurationHandler: nil)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
      //OKボタン
      if let txtField = alert.textFields?.first {
        let myTodo = MyTodo()
        myTodo.todoTitle = txtField.text!
        self.todoList.insert(myTodo, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.right)
        
        //UserDefaults保存処理
        let userdefaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: self.todoList)
        userdefaults.set(data, forKey: "todoList")
        userdefaults.synchronize()
      }
    }
    //OKボタン追加
    alert.addAction(okAction)
    
    //CANCELボタン
    let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler: nil)
    
    alert.addAction(cancelButton)
    
    //ダイアログ表示
    present(alert, animated: true, completion: nil)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
    let myTodo = todoList[indexPath.row]
    cell.textLabel?.text = myTodo.todoTitle
    
    //チェック状態設定
    if myTodo.todoDoneFlg {
      cell.accessoryType = UITableViewCellAccessoryType.checkmark
    } else {
      cell.accessoryType = UITableViewCellAccessoryType.none
    }
    return cell
  }
  
  //削除ボタン表示
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "削除"
  }
  
  //削除許可
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  //削除ボタン
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      todoList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
      
      let data: Data = NSKeyedArchiver.archivedData(withRootObject: todoList)
      let userdefaults = UserDefaults.standard
      userdefaults.set(data, forKey: "todoList")
      userdefaults.synchronize()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let myTodo = todoList[indexPath.row]
    if myTodo.todoDoneFlg {
      myTodo.todoDoneFlg = false
    } else {
      myTodo.todoDoneFlg = true
    }
    tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    
    //データ保存
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: todoList)
    let userdefaults = UserDefaults.standard
    userdefaults.set(data, forKey: "todoList")
    userdefaults.synchronize()
  }
}

