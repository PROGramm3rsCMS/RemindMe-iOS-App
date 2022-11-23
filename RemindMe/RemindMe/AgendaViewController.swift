//
//  AgendaViewController.swift
//  RemindMe
//
//  Created by Sammy Torres II on 11/8/22.
//

import UIKit
import Parse
import MessageInputBar

class AgendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    @IBOutlet var tableView: UITableView!
    
    let agendaBar = MessageInputBar()
    var showsAgendaBar = false
    
    var tasks = [PFObject]()
    var selectedTask: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        agendaBar.inputTextView.placeholder = "Add a task..."
        agendaBar.sendButton.title = "Tasks"
        agendaBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillBeHidden(note: Notification){
        agendaBar.inputTextView.text = nil
        showsAgendaBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return agendaBar
    }
    override var canBecomeFirstResponder: Bool{
        return showsAgendaBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // creates the query from Agenda
        let query = PFQuery(className: "Tasks")
        
        query.includeKeys(["creator", "agendas", "agendas.creator"])
        
        query.limit = 20
        
        query.findObjectsInBackground{ tasks, error in
            if(tasks != nil) {
                self.tasks = tasks!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let agenda = PFObject(className: "Agendas")
        agenda["username"] = PFUser.current()!
        agenda["moreTask"] = text
        agenda["task"] = selectedTask
        agenda["creator"] = PFUser.current()
        
        selectedTask.add(agenda, forKey: "agendas")
        
        selectedTask.saveInBackground{(success, error) in
            if (success) {
                print("Agenda saved!")
            }
            else {
                print("Error saving agenda!")
            }
        }
        
        tableView.reloadData()
        
        agendaBar.inputTextView.text = nil
        showsAgendaBar = false
        becomeFirstResponder()
        agendaBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      let task = tasks[section]
      
      let agendas = (task["agendas"] as? [PFObject]) ?? []
        
        return agendas.count + 2
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return tasks.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.section]
        
        let agendas = (task["agendas"] as? [PFObject]) ?? []
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
            
            cell.dateLabel.text = task["currentDate"] as! String
            
            return cell
        }
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
            
            cell.taskLabel.text = task["todo"] as! String
            
            return cell
            
        }
        else if indexPath.row <= agendas.count {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalTaskCell") as! AdditionalTaskCell
            
            let agenda = agendas[indexPath.row - 1]
            cell.additionalTaskCell.text = agenda["moreTask"] as? String
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAgendaCell")!
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.section]
        
        let agendas = (task["agendas"] as? [PFObject]) ?? []
        
        if (indexPath.row == agendas.count + 1) {
            showsAgendaBar = true
            becomeFirstResponder()
            agendaBar.inputTextView.becomeFirstResponder()
            
            selectedTask = task
            
        }

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
