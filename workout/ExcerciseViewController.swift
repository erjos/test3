import UIKit

class ExcerciseViewController: UIViewController {
    
    @IBOutlet weak var repDecrease: UIButton!
    @IBOutlet weak var repIncrease: UIButton!
   
    @IBOutlet weak var weightDecrease: UIButton!
    @IBOutlet weak var weightIncrease: UIButton!
    
    //green Hex: 42E287
    //red Hex: F66451

    override func viewDidLoad() {
        super.viewDidLoad()
        repDecrease.circleButton()
        repIncrease.circleButton()
        weightDecrease.circleButton()
        weightIncrease.circleButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let timer = Timer()
}

extension UIButton{
    
    //Rounds UIView corners with a cornerRadius of 10.0
    func circleButton(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2.0
    }
}
