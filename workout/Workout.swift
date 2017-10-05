import Foundation

class Workout {
    var concentration: String? //make an enumeration
    var excercises: [Excercise]?
    
    //not sure how I feel about these methods - experiment with pulling out the objects in line and this method to determine final solution
    func updateIsSetCompleteFor(_ excerciseAt: Int, _ setAt: Int, _ isComplete: Bool){
        let set = self.excercises?[excerciseAt].sets?[setAt]
        set?.isSetComplete = isComplete
    }
    
    func getIsSetComplete(_ excerciseAt: Int, _ setAt: Int) -> Bool {
        guard let isComplete = self.excercises?[excerciseAt].sets?[setAt].isSetComplete else {
            return false
        }
        return isComplete
    }
}
