import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var check: UIImageView!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stroke: UIView!
    @IBOutlet weak var title: UILabel!
    
    weak var delegate: WorkoutTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.check.isHidden = true
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
