import Foundation

class Workout {
    var concentration: String? //make an enumeration
    var excercises: [Excercise]?
    
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
