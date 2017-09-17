import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var stroke: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func start(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
