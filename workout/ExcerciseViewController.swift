import UIKit

class ExcerciseViewController: UIViewController {
    //IDEA: manual/auto toggle at the bottom of the page to allow the timere to go by itself and indicate using a single or double vibration
    
    //Increment sets counter after each round - stop when its finished 
        //-(could have something like isWorkoutActive bool to evaluate)
    
    @IBOutlet weak var repIncrease: UIButton!
    @IBOutlet weak var repDecrease: UIButton!
    @IBOutlet weak var weightDecrease: UIButton!
    @IBOutlet weak var weightIncrease: UIButton!
   
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var repCounter: UILabel!
    @IBOutlet weak var weightCounter: UILabel!
    
    var timer = Timer()
    
    //Default values for current workout
    private var repCount = 15
    private var weightCount = 135
    private var setCount = 0 //could have a setter method that evaluates current count to max number
    private var seconds: Double = 0
    
    @IBOutlet weak var startButton: UIButton!
    
    //green Hex: 42E287
    //red Hex: F66451
    let RED = UIColor(red: 246/255, green: 100/255, blue: 81/255, alpha: 255/255)
    let GREEN = UIColor(red: 66/255, green: 226/255, blue: 135/255, alpha: 255/255)
    
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
        repCount = repCount - 1
        repCounter.text = repCount.description
    }
    @IBAction func repIncreaseAction(_ sender: Any) {
        repCount = repCount + 1
        repCounter.text = repCount.description
    }
    @IBAction func weightDecAction(_ sender: Any) {
        weightCount = weightCount - 5
        weightCounter.text = weightCount.description
    }
    @IBAction func weightIncAction(_ sender: Any) {
        weightCount = weightCount + 5
        weightCounter.text = weightCount.description
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        repDecrease.circleView()
        repIncrease.circleView()
        repCounter.circleView()
        weightDecrease.circleView()
        weightIncrease.circleView()
        weightCounter.circleView()
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
