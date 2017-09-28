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
    
    let blue = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 255/255)
    let offWhite = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 255/255)
    
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
    
    func styleView(isSetComplete: Bool){
        self.hexagon.image = isSetComplete ? UIImage.init(named: "hexagon_border") : UIImage.init(named: "hex_gray_border")
        let itemColor = isSetComplete ? offWhite : blue
        setViewItemColor(color: itemColor)
    }
    
    func setViewItemColor(color: UIColor) {
        weightMinus.setTitleColor(color, for: .normal)
        weightPlus.setTitleColor(color, for: .normal)
        weightCount.textColor = color
        repMinus.setTitleColor(color, for: .normal)
        repPlus.setTitleColor(color, for: .normal)
        repCount.textColor = color
        divider.backgroundColor = color
    }
    
    @IBAction func toggleComplete(_ sender: Any) {
        isSetComplete = !isSetComplete
        styleView(isSetComplete: isSetComplete)
    }
}
