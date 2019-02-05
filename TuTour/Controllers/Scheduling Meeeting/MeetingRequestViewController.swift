//
//  MeetingRequestViewController.swift
//  TuTour
//
//  Created by Josh Kardos on 1/31/19.
//  Copyright © 2019 JoshTaylorKardos. All rights reserved.
//

import Foundation
import UIKit

class MeetingRequestViewController: UIViewController{
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var denyButton: UIButton!
	@IBOutlet var meetingRequestLabels: [UILabel]!
	//Subject
	//Student username
	//Building
	//Day
	//Time
	
	var user: User?
	var meetingRequest: MeetingRequest?
	
	@IBAction func denyPressed(_ sender: UIButton) {
        
        //ask to edit or kindly decline meeting
        let alert = UIAlertController(title: "Confirm", message: "Would you like to edit this request or deny and end talks?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Edit", comment: "Default action"), style: .default, handler: { _ in
            self.editMeetingRequest()}))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Deny", comment: "Default action"), style: .default, handler: { _ in
            self.deleteMeetingRequest()}))
        
        self.present(alert, animated: true, completion: nil)
        
        
	}
    
    func editMeetingRequest(){
        //present edit meeting request view
        
    }
    func deleteMeetingRequest(){
        //delete all nodes
        
        //pop to root view controller
        
    }
	@IBAction func acceptPressed(_ sender: UIButton) {
        
        //Add to users' array of scheduled meetings
        //store id
        print(meetingRequest!.meetingId)
        let alert = UIAlertController(title: "Confirm", message: "Would you like to confirm to plan this meeting?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            self.acceptMeeting()}))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")}))
        
        self.present(alert, animated: true, completion: nil)
        //delete meeting requests
        
        
	}
    func acceptMeeting(){
        print("MEETING STORED")
        //store in array of scheduled meetings for both users
        
    }
	func setUser(user: User){
		self.user = user
	}
	func setMeetingRequest(meetingRequest: MeetingRequest){
		self.meetingRequest = meetingRequest
	}
	
	
	
	//look under meetingRequestLabels declaration to get order of labels
	func fillMeetingRequestLabels(){
		
	
		
		//subject
		meetingRequestLabels[0].text = meetingRequest!.subject
		
		//username
		meetingRequestLabels[1].text = user!.username
		
		//building
		meetingRequestLabels[2].text = meetingRequest!.location
		
		//day
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM-dd-yyyy"
		meetingRequestLabels[3].text = dateFormatter.string(from: meetingRequest!.date!)
		//https://medium.com/@tjcarney89/using-dateformatter-to-format-dates-and-times-from-apis-57622ce11d04
		
		//time
		let dateFormatter2 = DateFormatter()
		dateFormatter2.dateFormat = "h:mm a"
		meetingRequestLabels[4].text = dateFormatter2.string(from: meetingRequest!.date!)
		
		
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		for i in 0..<meetingRequestLabels.count{
			print(meetingRequestLabels[i].text!)
		}
		fillMeetingRequestLabels()
		
		for i in 0..<meetingRequestLabels.count{
			print(meetingRequestLabels[i].text!)
		}
		
	}
}