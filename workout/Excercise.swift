import Foundation

class Excercise{
    var name: String?
    var concentration: String? //Make an enumeration
    var sets: [Set]?
    
    public init(name: String, sets: [Set]?) {
        self.name = name
        self.sets = sets
    }
    
}
