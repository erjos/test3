import UIKit

class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var currentWorkoutTitle: UIBarButtonItem!
    //IDEA - would be cool to animate the completion of a workout with the drawing of a check mark next to the excercise

    @IBOutlet weak var excerciseTable: UITableView!
    
    var currentWorkout: Workout?
    var selectedCellIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseTable.register(UINib.init(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //currentWorkout = mockChestWorkout()
        currentWorkoutTitle.title = (currentWorkout?.concentration)! + " Workout"
        
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
        excerciseVC.currentExcercise = currentWorkout?.excercises?[(selectedCellIndex?.row)!]
    }
}

extension WorkoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutTableViewCell
        cell.delegate = self
        cell.title.text = currentWorkout?.excercises?[indexPath.row].name
        cell.skipButton.isHidden = true
        cell.startButton.isHidden = true
        cell.stroke.isHidden = true
        return cell
    }
}

extension WorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectedCellIndex != nil){
            let previousCell = tableView.cellForRow(at: selectedCellIndex!) as! WorkoutTableViewCell
            previousCell.stroke.isHidden = true
            previousCell.startButton.isHidden = true
            previousCell.skipButton.isHidden = true
        }
        
        //TODO: encapsulate expand and collapse logic into single method that lives on the custom cell
        //If an already expanded cell is re-selected, then collapse the cell
        selectedCellIndex = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let cell = tableView.cellForRow(at: indexPath) as! WorkoutTableViewCell
        cell.startButton.isHidden = false
        cell.stroke.isHidden = false
        cell.skipButton.isHidden = false
//        self.performSegue(withIdentifier: "showExcercise", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedIndex = selectedCellIndex{
            if(indexPath == selectedIndex){
                return 140.00
            }
        }
        return 44.0
    }
}

extension WorkoutViewController: WorkoutTableViewCellDelegate{
    func didHitStartButton(cell: WorkoutTableViewCell) {
        self.performSegue(withIdentifier: "showExcercise", sender: self)
    }
}
