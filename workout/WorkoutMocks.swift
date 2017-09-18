import Foundation

class WorkoutMocks{
    
    class func generateSets(numberOfsets: Int, weight: Int?, toFail:Bool, reps: Int?) -> [Set]{
        var sets = [Set]()
        for _ in 0..<numberOfsets{
            let set = Set(weight: weight, toFailure: toFail, reps: reps)
            sets.append(set)
        }
        return sets
    }
    
    public class func mockChestWorkout() -> Workout {
        let mock = Workout()
        let exerc1 = Excercise(name: "Dumbbell Bench Press", sets: generateSets(numberOfsets: 4, weight: 55, toFail: false, reps: 12))
        let exerc2 = Excercise(name: "Dumbbell Incline", sets: generateSets(numberOfsets: 4, weight: 35, toFail: false, reps: 12))
        let exerc3 = Excercise(name: "Dumbbell Flyes", sets: generateSets(numberOfsets: 4, weight: 25, toFail: true, reps: nil))
        let exerc4 = Excercise(name: "Incline Hammer Curls", sets: generateSets(numberOfsets: 4, weight: 25, toFail: false, reps: 12))
        let exerc5 = Excercise(name: "Dips (chest)", sets: generateSets(numberOfsets: 4, weight: nil, toFail: true, reps: nil))
        let exerc6 = Excercise(name: "Cardio", sets: nil)
        mock.excercises = [exerc1, exerc2, exerc3, exerc4, exerc5, exerc6]
        mock.concentration = "Chest"
        return mock
    }
    
    public class func mockShoulderWorkout() -> Workout {
        let mock = Workout()
        let exerc1 = Excercise(name: "Dumbbell Shoulder Press", sets: generateSets(numberOfsets: 4, weight: 35, toFail: false, reps: 12))
        let exerc2 = Excercise(name: "Standing Military Press", sets: generateSets(numberOfsets: 4, weight: 40, toFail: false, reps: 12))
        let exerc3 = Excercise(name: "Front Dumbell Raise", sets: generateSets(numberOfsets: 4, weight: 20, toFail: false, reps: 12))
        let exerc4 = Excercise(name: "Side Lateral Raise", sets: generateSets(numberOfsets: 4, weight: 20, toFail: false, reps: 12))
        let exerc5 = Excercise(name: "Reverse Machine Flyes", sets: generateSets(numberOfsets: 4, weight: 60, toFail: false, reps: 15))
        let exerc6 = Excercise(name: "Seated Bent-Over Rear Delt Raise", sets: generateSets(numberOfsets: 4, weight: 15, toFail: false, reps: 12))
        let excerc7 = Excercise(name: "Cardio", sets: nil)
        mock.excercises = [exerc1, exerc2, exerc3, exerc4, exerc5, exerc6, excerc7]
        mock.concentration = "Shoulders"
        return mock
    }
    
    public class func mockArmsWorkout() -> Workout {
        let mock = Workout()
        let exerc1 = Excercise(name: "Dumbbell Bicep Curl", sets: generateSets(numberOfsets: 4, weight: 30, toFail: false, reps: 15))
        let exerc2 = Excercise(name: "Hammer Curl", sets: generateSets(numberOfsets: 4, weight: 15, toFail: false, reps: 15))
        let exerc3 = Excercise(name: "Preacher Curl", sets: generateSets(numberOfsets: 4, weight: 20, toFail: true, reps: nil))
        let exerc4 = Excercise(name: "Triceps Push Down", sets: generateSets(numberOfsets: 4, weight: 40, toFail: false, reps: 15))
        let exerc5 = Excercise(name: "Overhead Triceps", sets: generateSets(numberOfsets: 3, weight: 40, toFail: false, reps: 15))
        let exerc6 = Excercise(name: "Hanging Leg Raise", sets: generateSets(numberOfsets: 4, weight: nil, toFail: false, reps: 20))
        let exerc8 = Excercise(name: "Planks", sets: generateSets(numberOfsets: 3, weight: nil, toFail: true, reps: nil))
        let excerc7 = Excercise(name: "Cardio", sets: nil)
        mock.excercises = [exerc1, exerc2, exerc3, exerc4, exerc5, exerc6, exerc8, excerc7]
        mock.concentration = "Arms and Abs"
        return mock
    }
    
    public class func mockBackWorkout() -> Workout {
        let mock = Workout()
        let exerc1 = Excercise(name: "Wide-Grip Lat Pulldown", sets: generateSets(numberOfsets: 4, weight: 75, toFail: false, reps: 12))
        let exerc2 = Excercise(name: "One-Arm Dumbbell Row", sets: generateSets(numberOfsets: 4, weight: 40, toFail: false, reps: 12))
        let exerc3 = Excercise(name: "Pullups", sets: generateSets(numberOfsets: 3, weight: nil, toFail: true, reps: nil))
        let exerc4 = Excercise(name: "Dumbbell Shrug", sets: generateSets(numberOfsets: 4, weight: 50, toFail: false, reps: 12))
        let exerc5 = Excercise(name: "Seated Row Machine", sets: generateSets(numberOfsets: 4, weight: 70, toFail: false, reps: 12))
        let exerc6 = Excercise(name: "Inverted Row", sets: generateSets(numberOfsets: 3, weight: nil, toFail: true, reps: nil))
        let exerc8 = Excercise(name: "Hyperextensions (Back Extensions)", sets: generateSets(numberOfsets: 4, weight: nil, toFail: false, reps: 12))
        let excerc7 = Excercise(name: "Cardio", sets: nil)
        mock.excercises = [exerc1, exerc2, exerc3, exerc4, exerc5, exerc6, exerc8, excerc7]
        mock.concentration = "Back"
        return mock
    }

}
