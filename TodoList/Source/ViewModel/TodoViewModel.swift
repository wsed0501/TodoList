//
//  TodoViewModel.swift
//  TodoList
//
//  Created by 김효원 on 25/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

protocol TodoViewModelProtocol: class {
    var todoList: Array<Todo> { get set }
    var isOn: Bool { get set }
    
    // 값 변환기
    var todoDidChange: ((TodoViewModelProtocol) -> ())? { get set }
    
    // 명령
    func reloadTodo()
    func addTodo(content: String)
    func updateTodo(todo: Todo)
    func delTodo(row: Int)
    func completeTodo(row: Int, isComplete: Bool)
    func showCompleteTodo(isOn: Bool)
}

class TodoViewModel: TodoViewModelProtocol {
    var todoList: Array<Todo> {
        didSet {
            self.todoDidChange?(self)
        }
    }
    var isOn: Bool
    
    var todoDidChange: ((TodoViewModelProtocol) -> ())?
    
    init() {
        self.todoList = []
        self.isOn = false
    }
    
    func reloadTodo(){
        if let todoList = DataService.getTodoList(key: "todoList") {
            self.todoList = todoList
        }
        
        if !isOn {
            return
        }
        
        self.todoList = self.todoList.filter({ $0.isComplete == false })
    }
    
    func addTodo(content: String){
        DataService.addTodo(content: content)
        reloadTodo()
    }
    
    func updateTodo(todo: Todo){
        DataService.updateTodo(todo: todo)
        reloadTodo()
    }
    
    func delTodo(row: Int){
        DataService.delTodo(id: todoList[row].id!)
        reloadTodo()
    }
    
    func completeTodo(row: Int, isComplete: Bool) {
        var todo = todoList[row]
        todo.isComplete = isComplete
        
        updateTodo(todo: todo)
    }
    
    func showCompleteTodo(isOn: Bool){
        self.isOn = isOn
        reloadTodo()
    }
}
