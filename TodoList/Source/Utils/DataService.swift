//
//  DataService.swift
//  TodoList
//
//  Created by 김효원 on 25/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

class DataService {
    private static var todoList = Dictionary<String, Dictionary<String, Any>>()
    private static var id = 0
    
    static func getTodoList() -> Dictionary<String, Dictionary<String, Any>> {
        return todoList
    }
    
    static func setTodoList(_ todoList: Dictionary<String, Dictionary<String, Any>>){
        self.todoList = todoList
    }
    
    
    // MARK: - todo List 불러오기
    static func getTodoList(key: String) -> Array<Todo>? {
        var todoArray = Array<Todo>()
        
        for data in todoList {
            var todoData = data.value
            var todo = Todo()
            todo.id = data.key
            todo.content = todoData["content"] as? String
            todo.isComplete = todoData["isComplete"] as? Bool
            
            todoArray.append(todo)
        }
        
        // 배열 정렬
        todoArray = todoArray.sorted(by: { ($0.id! as NSString).integerValue < ($1.id! as NSString).integerValue })
        
        return todoArray
    }
    
    
    // MARK: - todo 추가
    static func addTodo(content: String) {
        let todoDictionary = [
            "content" : content,
            "isComplete" : false
            ] as [String : Any]
        
        todoList.updateValue(todoDictionary, forKey: "\(id)")
        id += 1
    }
    
    
    // MARK: - todo 업데이트
    static func updateTodo(todo: Todo){
        let todoDictionary = [
            "content" : todo.content ?? "",
            "isComplete" : todo.isComplete ?? false
            ] as [String : Any]
        
        todoList.updateValue(todoDictionary, forKey: todo.id!)
    }
    
    
    // MARK: - todo 삭제
    static func delTodo(id: String){
        todoList.removeValue(forKey: id)
    }
}
