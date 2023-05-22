//
//  ViewController.swift
//  CoreCloudApp
//
//  Created by kevin marinho on 21/05/23.
//

import UIKit

class ViewController: UIViewController {

    var tasksList = Task.fetchAll()
    var enteredTask = ""
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.reloadData()
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonTaped(_ sender: Any) {
        addNewTask()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIBarButtonItem) {
        deleteAllTask()
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        refreshTasks()
    }
    
    private func addNewTask(){
         self.enteredTask = taskTextField.text!
         saveTask(named: self.enteredTask)
         self.tasksList = Task.fetchAll()
         tabelView.reloadData()
         taskTextField.text = ""
    }
    
    private func saveTask(named name: String){
        let task = Task(context: AppDelegate.viewContext)
        task.taskName = name
        try? AppDelegate.viewContext.save()
    }
    
    private func deleteAllTask(){
        Task.deleteAll()
        tasksList = Task.fetchAll()
        tabelView.reloadData()
    }
    
    private func refreshTasks(){
        print("refresh")
        self.tasksList = Task.fetchAll()
        tabelView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "taskCell")
        cell.textLabel?.text = "- " + tasksList[indexPath.row].taskName!
        return cell
    }
    
    
}

