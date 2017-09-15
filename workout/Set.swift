import Foundation

class Set {
    var weight: Int?
    var reps: Int?
    var toFailure: Bool?
    
    public init(weight: Int?, toFailure: Bool, reps: Int?){
        self.weight = weight
        self.reps = reps
        self.toFailure = toFailure
    }
}
