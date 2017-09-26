import UIKit

class SetView: UIView {
    
    @IBOutlet weak var hexagon: UIImageView!
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var divider: UIView!
    
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
