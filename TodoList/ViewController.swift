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
  
  var todoList = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
        self.todoList.insert(txtField.text!, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.right)
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
    cell.textLabel?.text = todoList[indexPath.row]
    return cell
  }
}

