import Foundation

class Excercise{
    var name: String?
    var concentration: String? //Make an enumeration
    var sets: [Set]?
    
    public init(name: String, sets: [Set]?) {
        self.name = name
        self.sets = sets
    }
    
    //returns true if all the sets in the Excercise are complete
    public func isExerciseComplete() -> Bool {
        guard let sets = self.sets else {
            return false
        }
        for set in sets{
            if(!set.isSetComplete) { return false }
        }
        return true
    }
}
