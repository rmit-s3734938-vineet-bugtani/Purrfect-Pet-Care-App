
import UIKit

class HomeViewController: UIViewController,Storyboarded {
    
    private let notificationPublisher = NotificationPublisher()
    weak var coordinator : MainCoordinator?
    let owner = OwnerViewModel()

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileDesc: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var feedingAlarm: UITextField!
    @IBOutlet weak var playAlarm: UITextField!
    @IBOutlet weak var litterboxAlarm: UITextField!
    @IBOutlet weak var triviaTextView: UITextView!
    
    
    static var alarms = Alarm(feedingTime: nil , playTime: nil, litterBoxTime: nil)
    
    let triviaViewModel = TriviaViewModel()
    
    func displayTrivia() {
        let random = Int.random(in: 0 ... triviaViewModel.getTriviaArray().count-1)
        
        triviaTextView.text = triviaViewModel.getTriviaArray()[random]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        createToolbar()
        displayTrivia()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderWidth = 3
        let brightRed = UIColor(red: 0.94, green: 0.47, blue: 0.62, alpha: 1.0)
        profilePicture.layer.borderColor = brightRed.cgColor
        
        name.text = owner.getOwnerInfo().name
        profileDesc.text = owner.getOwnerInfo().description
        profilePicture.image = UIImage(named : owner.getOwnerInfo().imageName)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    // function to create the DatePicker for birth date and alarm
    func createDatePicker() {
        
        let timePicker =  UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        timePicker.datePickerMode = .time
        //                timePicker.locale = NSLocale.current
        timePicker.timeZone = NSTimeZone.local
        
        playAlarm.inputView = timePicker
        timePicker.addTarget(self, action: #selector(HomeViewController.timeChanged1(timePicker:)), for: .valueChanged)
        
        let timePicker2 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        feedingAlarm.inputView = timePicker2
        timePicker2.datePickerMode = .time
        timePicker2.addTarget(self, action: #selector(HomeViewController.timeChanged2(timePicker2:)), for: .valueChanged)
        
        let timePicker3 =  UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        litterboxAlarm.inputView = timePicker3
        timePicker3.datePickerMode = .time
        timePicker3.addTarget(self, action: #selector(HomeViewController.timeChanged3(timePicker3:)), for: .valueChanged)
        
        
        
    }
    
    @objc func timeChanged1(timePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        playAlarm.text = dateFormatter.string(from: timePicker.date)
        
        let playTime = dateFormatter.date(from: playAlarm.text!)
        HomeViewController.alarms.playTime = playTime!
        
        notificationPublisher.sendPlayNotification()
        
    }
    
    
    @objc func timeChanged2(timePicker2: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        feedingAlarm.text = dateFormatter.string(from: timePicker2.date)
        
        let feedingTime = dateFormatter.date(from: feedingAlarm.text!)
        HomeViewController.alarms.feedingTime = feedingTime!
        
        notificationPublisher.sendFeedingNotification()
    }
    
    @objc func timeChanged3(timePicker3: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        litterboxAlarm.text = dateFormatter.string(from: timePicker3.date)
        
        let litterboxTime = dateFormatter.date(from: litterboxAlarm.text!)
        HomeViewController.alarms.litterBoxTime = litterboxTime!
        
        notificationPublisher.sendLitterBoxNotification()
    }
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddCatViewController.dissmissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        playAlarm.inputAccessoryView = toolBar
        feedingAlarm.inputAccessoryView = toolBar
        litterboxAlarm.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    
    
}




