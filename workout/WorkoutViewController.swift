import UIKit

class WorkoutViewController: UIViewController {
    //IDEA - would be cool to animate the completion of a workout with the drawing of a check mark next to the excercise
    
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var currentWorkoutTitle: UIBarButtonItem!
    @IBOutlet weak var excerciseTable: UITableView!
    
    var modelWorkout: Workout?
    var selectedCellIndex: IndexPath?
    
    var setView: SetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseTable.register(UINib.init(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //currentWorkout = mockChestWorkout()
        currentWorkoutTitle.title = (modelWorkout?.concentration)! + " Workout"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "left-arrow")
        imageView.image = image
        let gestures = UITapGestureRecognizer(target: self, action: #selector(popVC))
        imageView.addGestureRecognizer(gestures)
        backItem.customView = imageView
    }
    
    func popVC(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let excerciseVC = segue.destination as! ExcerciseViewController
        excerciseVC.modelExcercise = modelWorkout?.excercises?[(selectedCellIndex?.row)!]
    }
    
    func closeSetView(){
        self.setView.removeFromSuperview()
    }
    
    func doubleTapCell(){
        setView = Bundle.main.loadNibNamed("SetView", owner: self, options: nil)?[0] as! SetView
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeSetView))
        closeTap.delegate = self
        setView.addGestureRecognizer(closeTap)
        
        self.view.addSubview(setView)
    }
}

extension WorkoutViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let containedInHex = self.setView.hexagon.frame.contains(touch.location(in: self.setView))
        
        if(containedInHex){
            return false
        }else{
            return true
        }
    }
}

extension WorkoutViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension WorkoutViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hexCell", for: indexPath)
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapCell))
        
        doubletap.numberOfTapsRequired = 2
        
        cell.addGestureRecognizer(doubletap)
            
        return cell
    }
}

extension WorkoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (modelWorkout?.excercises?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutTableViewCell
        cell.delegate = self
        cell.title.text = modelWorkout?.excercises?[indexPath.row].name
        //cell.skipButton.isHidden = true
        //cell.startButton.isHidden = true
        cell.collectionView.isHidden = true
        cell.stroke.isHidden = true
        cell.collectionView.register(UINib.init(nibName: "HexCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hexCell")
        return cell
    }
}

extension WorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //this successfuly closes the cell if you click it again, without fucking up the other shit
        if(selectedCellIndex == indexPath){
            let previousCell = tableView.cellForRow(at: selectedCellIndex!) as! WorkoutTableViewCell
            previousCell.stroke.isHidden = true
            previousCell.collectionView.isHidden = true
            selectedCellIndex = nil
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return
        }
        
        if(selectedCellIndex != nil){
            let previousCell = tableView.cellForRow(at: selectedCellIndex!) as! WorkoutTableViewCell
            previousCell.stroke.isHidden = true
            previousCell.collectionView.isHidden = true
            //previousCell.startButton.isHidden = true
            //previousCell.skipButton.isHidden = true
        }
        
        //TODO: encapsulate expand and collapse logic into single method that lives on the custom cell
        //If an already expanded cell is re-selected, then collapse the cell
        selectedCellIndex = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let cell = tableView.cellForRow(at: indexPath) as! WorkoutTableViewCell
        //cell.startButton.isHidden = false
        cell.collectionView.isHidden = false
        cell.stroke.isHidden = false
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        
        //cell.skipButton.isHidden = false
//        self.performSegue(withIdentifier: "showExcercise", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedIndex = selectedCellIndex{
            if(indexPath == selectedIndex){
                return 333.0
            }
        }
        return 64.0
    }
}

extension WorkoutViewController: WorkoutTableViewCellDelegate{
    func didHitStartButton(cell: WorkoutTableViewCell) {
        self.performSegue(withIdentifier: "showExcercise", sender: self)
    }
}
