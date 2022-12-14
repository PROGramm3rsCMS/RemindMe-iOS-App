Original App Design Project
===

# RemindMe

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Users will have the ability to create and check off a daily to-do list.
The app can help users stay on task, personally or professionally.  

### App Evaluation
- **Category:** Productivity
- **Mobile:** Primary efforts for the app would be for mobile development 
since the app could utilize push notifications and provide real-time 
data (completion of a task).  However, the app could offer some practical 
applications on a computer, like quickly adding or completing a task.  
As a reminder, the mobile version will contain more robust features, but 
the team will provide support for computer use.
- **Story:** Users will have the ability to create and manage their daily 
tasks.  Users can mark off the completion of each job once the desired 
task is executed.  If users have any unfinished tasks, they can decide to 
move them to the next calendar date.
- **Market:** Any group, including students, stay-at-home parents, and 
professionals, can use the app. Currently, the app does not have any 
social features. However, to provide some level of safety, users under the 
age of 13 would require parental, guardian, or adult permission.
- **Habit:** The app requires high-level interaction from users since users 
are the ones creating and marking the completion of daily tasks.  This daily 
requirement to mark off any job completion could make habit-forming interaction 
since users can visualize increased productivity and organization.  Users' 
personality types and how organized users are will determine the users' 
frequency or infrequency.
- **Scope:** At the project's inception, users will have access to create 
multiple daily tasks and mark the completion of daily tasks, along with the 
chance to move incomplete tasks to the next day.  The evolution of the app could 
lead to a productivity-sharing application, which could increase downloads.  
Sharing accomplishments and milestones could potentially lead to using social 
media apps like Facebook, Instagram, and Twitter.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] Users can create or log in to an account to access the current task.
- [x] Users can create a task for their daily schedule.
- [ ] Users can mark the completion of a task.
- [x] Users can remove or edit a task altogether.
- [ ] Users can add uncompleted tasks to the next day on the calendar.

**Optional Nice-to-have Stories**

* Users can set reminders for any task.
* Users can set a level of priority for each task.
* Users can share daily accomplishments with other users on social media.

### 2. Screen Archetypes

* Login/Register Screen
   * User can create a account if they are new, otherwise they are able to log in with a existing account to gain access to the home screen.
* Home Screen
   * User is able to select a date.
   * User is able to view the list of their tasks.
   * User is able to mark a task as completed.
   * User is able to tap a button to create a task.
   * User is able to remove/edit a task.
* Move Task Screen
   * User is able to move a task to a different date.
* Adding Task Screen
   * User is able to enter the task they want to create.
* Updating Task Screen
   * Allows user to edit a existing task.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Login/Registration
* Homepage
* Create new Task
* Update Task
* Move task
* Remove task

**Flow Navigation** (Screen to Screen)

* Login/Registration ???> Homepage
   * Homepage <??? ???> Create Tasks
   * (Optional) Homepage <??? ???> Edit Tasks
   * (Optional) Homepage <??? ???> Remove Tasks
   * (Optional) Homepage <??? ???> Move Tasks to another date

## Wireframes

Paper Wireframe 

![1b15f4d3-5b4c-46a9-aef1-ca5e47c175dc](https://user-images.githubusercontent.com/111750721/199243785-30ea5199-a036-4e3b-9482-560aa2f9a402.JPG)


### [BONUS] Digital Wireframes & Mockups

Digital Wireframe

![Component 1](https://user-images.githubusercontent.com/111750721/199242565-0f770225-44ad-402d-b05a-3a461aa94c10.png)

![Component 2](https://user-images.githubusercontent.com/111750721/199242581-94b82711-4c9a-4f76-bdbb-6c31280b4ea3.png)

Mockups

![Mockups 1](https://user-images.githubusercontent.com/111750721/199241082-59b8caaa-bde9-4743-8fe1-462b2266bf4e.png)

![Mockups 2](https://user-images.githubusercontent.com/111750721/199241104-2b36574a-b247-4d93-bff5-6172692d768f.png)


### [BONUS] Interactive Prototype
<img src='http://g.recordit.co/KT7iIjCxFG.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Schema 

### Models

User

| **Property** | **Type** | **Description** |
| ------------ | ------------- | ----------- |
| objectId     | String        | unique id for the user (default field) |
| username     | String        | username used to create or login to app     |
| password     | String        | password allows the correct user to login to app |
| createdAt    | DateTime      | date when a user name and password is created (default field) |
| updatedAt    | DateTime      | date when a user name and password is last updated (default field) |

Task

| **Property** | **Type** | **Description** |
| ------------ | ----------- | ----------- |
| objectId     | String      | unique id for the user task (default field)                     |
| task         | String      | task that the user creates |
| author       | Pointer to User | task author |
| createdAt    | DateTime    | date when user creates task (default field) |
| updatedAt    | DateTime    | date when task is last updated (default field) |

### Networking
List of network requests by screen

* Profile Screen
  * (Read/GET) Query logged in user object
  ```@IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    } ```

* Home Feed Screen
  * (Update/PUT) Update when a task is complete
  * (Delete) Delete existing Task
  * (Read/GET) Query all tasks where user is author
  
```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
```

* Create Task Screen
  * (Create/POST) Creating a new task
  
``` 
class ToDoItem: NSObject {
  var id: String
  var image: String
  var title: String
  var date: Date
  
  init(id: String, image: String, title: String, date: Date) {
    self.id = id
    self.image = image
    self.title = title
    self.date = date
  }
}
```


* Move Existing Task Screen
  * (Update/PUT) Updating existing Task to another date
  
```  
  struct ContentView: View {
      @State private var wakeUp = Date.now
      
      var body: some View {
          DatePicker("Please enter a date", selection: $wakeUp)
      }
  }
  
  struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
          ContentView()
     }
  }
```
* Update Existing Task Screen 
  * (Update/PUT) Update existing Task
```
let aString = "This is my string"
let newString = aString.replacingOccurrences(of: " ", with: "+")
```
## Video Walkthrough

Here's a walkthrough of implemented user stories Sprint 3:

<img src='http://g.recordit.co/mrexCqq0B7.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here's a walkthrough of implemented user stories Sprint 2:

<img src='http://g.recordit.co/ctoksNq5T8.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Here's a walkthrough of implemented user stories Sprint 1:

<img src='http://g.recordit.co/cyHH59ln8Q.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='http://g.recordit.co/0Uthyfwvk0.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
