import UIKit

class ExcerciseViewController: UIViewController {
    
    
    @IBOutlet weak var repIncrease: UIButton!
    @IBOutlet weak var repDecrease: UIButton!
    @IBOutlet weak var weightDecrease: UIButton!
    @IBOutlet weak var weightIncrease: UIButton!
   
    @IBOutlet weak var repCounter: UILabel!
    @IBOutlet weak var weightCounter: UILabel!
    
    var repInit = 15
    var weightInit = 135
    
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
        repInit = repInit - 1
        repCounter.text = repInit.description
    }
    @IBAction func repIncreaseAction(_ sender: Any) {
        repInit = repInit + 1
        repCounter.text = repInit.description
    }
    @IBAction func weightDecAction(_ sender: Any) {
        weightInit = weightInit - 5
        weightCounter.text = weightInit.description
    }
    @IBAction func weightIncAction(_ sender: Any) {
        weightInit = weightInit + 5
        weightCounter.text = weightInit.description
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
