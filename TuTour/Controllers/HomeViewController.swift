//
//  HomeViewController.swift
//  GolfGram
//
//  Created by Josh Kardos on 9/25/18.
//  Copyright © 2018 JoshTaylorKardos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ChameleonFramework

class HomeViewController: UIViewController {

	@IBOutlet weak var logOutButton: UIBarButtonItem!
	@IBOutlet weak var tableView: UITableView!
	
	
	var posts = [Post]()
	var following = [String]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		logOutButton.tintColor = UIColor.flatGreenDark
        // Do any additional setup after loading the view.
    }
	override func viewWillAppear(_ animated: Bool) {
		
		posts.removeAll()
		following.removeAll()
		loadPosts()
	}
	func loadPosts(){
	

		let ref = Database.database().reference()
//
//		for i in 0..<subjectsArray.count{
//			let newRef = ref.child("subject-users")
//			let subjectId = newRef.childByAutoId().key
//			let newSubjectRef = newRef.child(subjectsArray[i])
//
//			newSubjectRef.setValue(["subjectName": subjectsArray[i], "id": subjectId!])
//
//
//		}
//
		
		posts.removeAll()
		following.removeAll()
		
		//access posts
		ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
			
			//all users
			let users = snapshot.value as! [String: AnyObject]
			for(_, user) in users {
				//
				if let uid = user["uid"] as? String {
					if uid == Auth.auth().currentUser?.uid{
						//current user
					
						//access followers of current user
						if let followingUsers = user["following"] as? [String: String]{
							for(_, user) in followingUsers{
								self.following.append(user)//add all the user's following
							}
							//following is filled
						}
						//access posts
						ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in//get all posts
							
							if	let posts = snap.value as? [String: AnyObject]{
							
							for(_, post) in posts {
								//individual post
								if let userId = post["senderId"] as? String {
									for each in self.following {
										if each == userId {
											if let caption = post["caption"] as? String, let photoId = post["photoId"] as? String, let photoUrl = post["photoUrl"]as? String, let senderId = post["senderId"] as? String{
												
												let posst = Post(captionString: caption, photoIdString: photoId, photoUrlString: photoUrl, senderIdString: senderId)

												self.posts.append(posst)
					
											}
										}
									}
									self.tableView.reloadData()
								}
							}
							}
						})
					}
				}
			}
			
			
			
		}
		
		
	}
	@IBAction func logoutPressed(_ sender: Any) {
			
		do {
			try Auth.auth().signOut()
			
			let storyboard = UIStoryboard(name: "Start", bundle: nil)
			
			let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
			
			self.present(signInVC, animated: true, completion: nil)
		
		} catch let logoutError{
		
			print(logoutError)
		
		}
	
	}
	

}

//provide info to table view

extension HomeViewController: UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return posts.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCellViewController

		let url = URL(string: posts[indexPath.row].photoUrl!)//NSURL.init(fileURLWithPath: posts[indexPath.row].photoUrl)
		let imageData = NSData.init(contentsOf: url as! URL)
		cell.backgroundColor = UIColor.flatLime
		cell.cellImage.image = UIImage(data: imageData as! Data)
		cell.cellLabel.text = self.posts[indexPath.row].caption
		
		Database.database().reference().child("users").child(posts[indexPath.row].senderId!).observeSingleEvent(of: .value, with: {(snapshot) in
			
			let username = (snapshot.value as! NSDictionary)["username"] as! String
			
			cell.usernameLabel.text = username
			
		})
		
		
		
		
		return cell
	}






}