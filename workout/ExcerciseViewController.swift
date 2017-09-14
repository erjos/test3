import UIKit

class ExcerciseViewController: UIViewController {
    //Models: Routine, Session, Workout, Set
    //Timer - when you hit go start counting up, when you hit break count down from 90
    //Increment sets counter after each round - stop when its finished 
        //-(could have something like isWorkoutActive bool to evaluate)
    
    @IBOutlet weak var repIncrease: UIButton!
    @IBOutlet weak var repDecrease: UIButton!
    @IBOutlet weak var weightDecrease: UIButton!
    @IBOutlet weak var weightIncrease: UIButton!
   
    @IBOutlet weak var repCounter: UILabel!
    @IBOutlet weak var weightCounter: UILabel!
    
    //Default values for current workout
    
    private var repCount = 15
    private var weightCount = 135
    private var setCount = 0 //could have a setter method that evaluates current count to max number
    
    @IBOutlet weak var startButton: UIButton!
    
    //green Hex: 42E287
    //red Hex: F66451
    let RED = UIColor(red: 246/255, green: 100/255, blue: 81/255, alpha: 255/255)
    let GREEN = UIColor(red: 66/255, green: 226/255, blue: 135/255, alpha: 255/255)
    
    //IDEA: Go button might be able to incorporated into the timer
    @IBAction func startWorkout(_ sender: Any) {
        
        if(startButton.backgroundColor != RED){
            startButton.backgroundColor = RED
            startButton.setTitle("Break", for: .normal)
        }else{
            startButton.backgroundColor = GREEN
            startButton.setTitle("GO!", for: .normal)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let timer = Timer()
}

extension UIView{
    
    //Rounds UIView corners with a cornerRadius of 10.0
    func circleView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2.0
    }
}
