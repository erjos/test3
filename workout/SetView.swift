import UIKit

class SetView: UIView {
    
    @IBOutlet weak var hexagon: UIImageView!
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var divider: UIView!
    
    @IBOutlet weak var weightMinus: UIButton!
    @IBOutlet weak var weightPlus: UIButton!
    @IBOutlet weak var weightCount: UILabel!
    
    @IBOutlet weak var repMinus: UIButton!
    @IBOutlet weak var repPlus: UIButton!
    @IBOutlet weak var repCount: UILabel!
    
    private var repCounter: Int?
    private var weightCounter: Int?
    
    
    @IBAction func weightDecrease(_ sender: Any) {
        guard let weight = weightCounter else {
            return
        }
        weightCounter = weight - 5
        weightCount.text = weightCounter?.description
    }
    
    @IBAction func weightIncrease(_ sender: Any) {
        guard let weight = weightCounter else {
            return
        }
        weightCounter = weight + 5
        weightCount.text = weightCounter?.description
    }
    
    @IBAction func repDecrease(_ sender: Any) {
        guard let reps = repCounter else {
            return
        }
        repCounter = reps - 1
        repCount.text = repCounter?.description
    }
    
    @IBAction func repIncrease(_ sender: Any) {
        guard let reps = repCounter else {
            return
        }
        repCounter = reps + 1
        repCount.text = repCounter?.description
    }
    
    
    var isSetComplete: Bool = false
    
    func setComplete(){
        self.hexagon.image = UIImage.init(named: "hexagon_border")
        isSetComplete = true
    }
    
    func setIncomplete(){
        self.hexagon.image = UIImage.init(named: "hex_gray_border")
        isSetComplete = false
    }
    
    @IBAction func toggleComplete(_ sender: Any) {
        self.hexagon.image = isSetComplete ? UIImage.init(named: "hex_gray_border") : UIImage.init(named: "hexagon_border")
        isSetComplete = !isSetComplete
    }
}
