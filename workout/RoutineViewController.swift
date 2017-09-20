import UIKit

class RoutineViewController: UIViewController {
    
    @IBOutlet weak var routineLabel: UIBarButtonItem!
    @IBOutlet weak var workoutTable: UITableView!
    
    var routine: Routine?
    var selectedWorkout: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //Set the users routine
        routine = WorkoutMocks.mockRoutine()
        
        //Hides nav bar shadow for current page
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.routineLabel.title = routine?.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let workoutVC = segue.destination as! WorkoutViewController
        workoutVC.modelWorkout = selectedWorkout
    }
    
}

extension RoutineViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine?.workouts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.routine?.workouts?[indexPath.row].concentration
        return cell
    }
}

extension RoutineViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWorkout = routine?.workouts?[indexPath.row]
        self.performSegue(withIdentifier: "showWorkout", sender: self)
    }
}
