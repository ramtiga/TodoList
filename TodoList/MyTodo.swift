//
//  MyTodo.swift
//  TodoList
//
//  Created by Dai Haneda on 2017/09/30.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import Foundation

class MyTodo: NSObject, NSCoding {
  var todoTitle: String?
  var todoDoneFlg: Bool = false
  
  override init() {
  }

  //デコード処理
  required init?(coder aDecoder: NSCoder) {
    todoTitle = aDecoder.decodeObject(forKey: "todoTitle") as? String
    todoDoneFlg = aDecoder.decodeBool(forKey: "todoDoneFlg")
  }
  
  //エンコード処理
  func encode(with aCoder: NSCoder) {
    aCoder.encode(todoTitle, forKey: "todoTitle")
    aCoder.encode(todoDoneFlg, forKey: "todoDoneFlg")
  }
}
