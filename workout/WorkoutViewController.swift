import UIKit

class WorkoutViewController: UIViewController {
    
    //Todo: create custom cell - give it elements that show or hide based on isExpanded bool

    @IBOutlet weak var excerciseTable: UITableView!
    
    var currentWorkout: Workout?
    var selectedCellIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseTable.register(UINib.init(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //excerciseTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        currentWorkout = mockChestWorkout()
    }
    
    public func generateSets(numberOfsets: Int, weight: Int?, toFail:Bool, reps: Int?) -> [Set]{
        var sets = [Set]()
        for _ in 0..<numberOfsets{
            let set = Set(weight: weight, toFailure: toFail, reps: reps)
            sets.append(set)
        }
        return sets
    }
    
    public func mockChestWorkout() -> Workout {
        let mock = Workout()
        let exerc1 = Excercise(name: "Dumbbell Bench Press", sets: generateSets(numberOfsets: 4, weight: 55, toFail: false, reps: 12))
        let exerc2 = Excercise(name: "Dumbbell Incline", sets: generateSets(numberOfsets: 4, weight: 35, toFail: false, reps: 12))
        let exerc3 = Excercise(name: "Dumbbell Flyes", sets: generateSets(numberOfsets: 4, weight: 25, toFail: true, reps: nil))
        let exerc4 = Excercise(name: "Incline Hammer Curls", sets: generateSets(numberOfsets: 4, weight: 25, toFail: false, reps: 12))
        let exerc5 = Excercise(name: "Dips (chest)", sets: generateSets(numberOfsets: 4, weight: nil, toFail: true, reps: nil))
        let exerc6 = Excercise(name: "Cardio", sets: nil)
        mock.excercises = [exerc1, exerc2, exerc3, exerc4, exerc5, exerc6]
        return mock
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WorkoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutTableViewCell
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
        //self.performSegue(withIdentifier: "showExcercise", sender: self)
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