import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var stroke: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    weak var delegate: WorkoutTableViewCellDelegate?
    
    @IBAction func start(_ sender: Any) {
        delegate?.didHitStartButton(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func startAction(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol WorkoutTableViewCellDelegate: class {
    func didHitStartButton(cell: WorkoutTableViewCell)
}
