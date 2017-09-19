import UIKit

class ExcerciseViewController: UIViewController {
    //IDEA: manual/auto toggle at the bottom of the page to allow the timere to go by itself and indicate using a single or double vibration
    
    //Increment sets counter after each round - stop when its finished 
        //-(could have something like isWorkoutActive bool to evaluate)
    
    //TODO: change to "currentExcerciseName"
    @IBOutlet weak var currentWorkoutName: UIBarButtonItem!
    
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var repIncrease: UIButton!
    @IBOutlet weak var repDecrease: UIButton!
    @IBOutlet weak var weightDecrease: UIButton!
    @IBOutlet weak var weightIncrease: UIButton!
   
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var repCounter: UILabel!
    @IBOutlet weak var weightCounter: UILabel!
    @IBOutlet weak var setCounter: UILabel!
    
    var timer = Timer()
    
    //Default values for current workout
    private var repCount: Int?
    private var weightCount: Int?
    private var setCount: Int?
    private var seconds: Double = 0
    
    @IBOutlet weak var startButton: UIButton!
    
    //green Hex: 42E287
    //red Hex: F66451
    let RED = UIColor(red: 246/255, green: 100/255, blue: 81/255, alpha: 255/255)
    let GREEN = UIColor(red: 66/255, green: 226/255, blue: 135/255, alpha: 255/255)
    
    var currentExcercise: Excercise?
    
    //IDEA: Go button might be able to incorporated into the timer
    @IBAction func startWorkout(_ sender: Any) {
        //Change this to a more logical bool - isSetStarted = false
        if(startButton.backgroundColor != RED){
            timerText.text = "00:00"
            startButton.backgroundColor = RED
            startButton.setTitle("Break", for: .normal)
            runTimer()
        }else{
            timerText.text = "01:30"
            startButton.backgroundColor = GREEN
            startButton.setTitle("GO!", for: .normal)
            runBreakTimer()
            
        }
    }
    
    
    //TODO: these actions all need to work if you hold down (modify gesture)
    @IBAction func repDecreaseAction(_ sender: Any) {
        guard let reps = repCount else {
            return
        }
        repCount = reps - 1
        repCounter.text = repCount?.description
    }
    @IBAction func repIncreaseAction(_ sender: Any) {
        guard let reps = repCount else {
            return
        }
        repCount = reps + 1
        repCounter.text = repCount?.description
    }
    @IBAction func weightDecAction(_ sender: Any) {
        guard let weight = weightCount else {
            return
        }
        weightCount = weight - 5
        weightCounter.text = weightCount?.description
    }
    @IBAction func weightIncAction(_ sender: Any) {
        guard let weight = weightCount else {
            return
        }
        weightCount = weight + 5
        weightCounter.text = weightCount?.description
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup circle views---
        repDecrease.circleView()
        repIncrease.circleView()
        repCounter.circleView()
        weightDecrease.circleView()
        weightIncrease.circleView()
        weightCounter.circleView()
        //---
        
        //Setup back arrow---
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "left-arrow")
        imageView.image = image
        let gestures = UITapGestureRecognizer(target: self, action: #selector(popVC))
        imageView.addGestureRecognizer(gestures)
        backItem.customView = imageView
        //---
        
        //setup data for view---
        currentWorkoutName.title = currentExcercise?.name
            //setup sets
        let sets =  currentExcercise?.sets?.count.description ?? "NA"
        setCounter.text = "0/" + sets
        
            //setup reps
        repCount = currentExcercise?.sets?[0].reps
        let reps = repCount?.description ?? "N/A"
        repCounter.text = reps
            //setup weight
        weightCount = currentExcercise?.sets?[0].weight
        let weight = weightCount?.description ?? "N/A"
        weightCounter.text = weight
        //---
    }
    
    func popVC(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func runTimer(){
        timer.invalidate()
        seconds = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func runBreakTimer(){
        timer.invalidate()
        seconds = 90
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    func updateBreakTimer(){
        if(seconds == 0){
            timer.invalidate()
            return
        }
        seconds -= 1
        timerText.text = "\(timeString(time: seconds))"
    }
    
    func updateTimer(){
        seconds += 1
        timerText.text = "\(timeString(time: seconds))"
    }
    
    func timeString(time:TimeInterval) -> String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension UIView{
    
    //Rounds UIView corners with a cornerRadius of 10.0
    func circleView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2.0
    }
}
