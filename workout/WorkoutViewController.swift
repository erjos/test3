import UIKit

class WorkoutViewController: UIViewController {
    //IDEA - would be cool to animate the completion of a workout with the drawing of a check mark next to the excercise
    
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var currentWorkoutTitle: UIBarButtonItem!
    @IBOutlet weak var excerciseTable: UITableView!
    
    var modelWorkout: Workout?
    var selectedExcerciseCellIndex: IndexPath?
    var selectedSetIndex: IndexPath?
    
    //SET VIEW
    var setView: SetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseTable.register(UINib.init(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        currentWorkoutTitle.title = (modelWorkout?.concentration)! + " Workout"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "left-arrow")
        imageView.image = image
        let gestures = UITapGestureRecognizer(target: self, action: #selector(popVC))
        imageView.addGestureRecognizer(gestures)
        
        //setup constranints for buttons
        let height = imageView.heightAnchor.constraint(equalToConstant: 32.0)
        let width = imageView.widthAnchor.constraint(equalToConstant: 32.0)
        height.isActive = true
        width.isActive = true
        
        backItem.customView = imageView
        //backItem.width = 32
    }
    
    @objc func popVC(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    //SET VIEW
    @objc func closeSetView(){
        self.setView.removeFromSuperview()
        if(setView.isSetComplete){
            //set collectionview cell image to complete
            let tableCell = excerciseTable.cellForRow(at: selectedExcerciseCellIndex!) as? WorkoutTableViewCell
            let collectionCell = tableCell?.collectionView.cellForItem(at: selectedSetIndex!) as? HexCollectionViewCell
            collectionCell?.imageView.image = UIImage.init(named: "hexagon_border")
            
            //set isSetComplete Bool to complete on model - move this into a function
            modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].isSetComplete = true
            
            //update weight and reps on the set
            modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].weight = setView.weightCounter
            modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].reps = setView.repCounter
            
        }else{
            let tableCell = excerciseTable.cellForRow(at: selectedExcerciseCellIndex!) as? WorkoutTableViewCell
            let collectionCell = tableCell?.collectionView.cellForItem(at: selectedSetIndex!) as? HexCollectionViewCell
            collectionCell?.imageView.image = UIImage.init(named: "hex_gray_border")
            modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].isSetComplete = false
            
            //update weight and reps on the set
            modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].weight = setView.weightCounter
            modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].reps = setView.repCounter
        }
    }
    
    //SET VIEW
    func tapCell(){
        setView = Bundle.main.loadNibNamed("SetView", owner: self, options: nil)?[0] as! SetView
        
        setView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        let set = modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!]
        let reps = set?.reps
        let weight = set?.weight
        
        setView.setRepCounter(reps: reps)
        setView.setWeightCounter(weight: weight)
        
        if let isSetComplete = modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?[(selectedSetIndex?.row)!].isSetComplete {
            setView.styleView(isSetComplete: isSetComplete)
            setView.toggle.isOn = isSetComplete
            setView.isSetComplete = isSetComplete
        }
        
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeSetView))
        closeTap.delegate = self
        setView.addGestureRecognizer(closeTap)
        setView.backgroundColor = setView.backgroundColor?.withAlphaComponent(0.0)
        
        self.view.addSubview(setView)
        
        //Completion should eventually dictate when the buttons appear
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            self.setView.backgroundColor = self.setView.backgroundColor?.withAlphaComponent(0.69)
        }, completion: nil)
    }
}

//SET VIEW
extension WorkoutViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let containedInHex = self.setView.hexagon.frame.contains(touch.location(in: self.setView))
        return !containedInHex
    }
}

extension WorkoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSetIndex = indexPath
        tapCell()
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
        guard let sets = modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!].sets?.count else {
            return 1
        }
        return sets
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hexCell", for: indexPath) as! HexCollectionViewCell
        let currentExcercise = modelWorkout?.excercises?[(selectedExcerciseCellIndex?.row)!]
        
        guard let isSetComplete = currentExcercise?.sets?[indexPath.row].isSetComplete else {
            cell.imageView.image = UIImage.init(named: "hex_gray_border")
            return cell
        }
        
        if(isSetComplete){
            cell.imageView.image = UIImage.init(named: "hexagon_border")
        } else {
            cell.imageView.image = UIImage.init(named: "hex_gray_border")
        }
            
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
        cell.collectionView.isHidden = true
        cell.stroke.isHidden = true
        cell.collectionView.register(UINib.init(nibName: "HexCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hexCell")
        return cell
    }
}

extension WorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //this successfuly closes the cell if you click it again, without fucking up the other shit
        if(selectedExcerciseCellIndex == indexPath){
            let previousCell = tableView.cellForRow(at: selectedExcerciseCellIndex!) as! WorkoutTableViewCell
            previousCell.stroke.isHidden = true
            previousCell.collectionView.isHidden = true
            selectedExcerciseCellIndex = nil
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return
        }
        
        if(selectedExcerciseCellIndex != nil){
            let previousCell = tableView.cellForRow(at: selectedExcerciseCellIndex!) as! WorkoutTableViewCell
            previousCell.stroke.isHidden = true
            previousCell.collectionView.isHidden = true
        }
        
        //TODO: encapsulate expand and collapse logic into single method that lives on the custom cell
        selectedExcerciseCellIndex = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let cell = tableView.cellForRow(at: indexPath) as! WorkoutTableViewCell
        cell.collectionView.isHidden = false
        cell.stroke.isHidden = false
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        
        //Ensures that the collectionView datasource methods are called everytime the cell expands
        cell.collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedIndex = selectedExcerciseCellIndex{
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
