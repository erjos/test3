import UIKit

class ExcerciseViewController: UIViewController {
    //IDEA: manual/auto toggle at the bottom of the page to allow the timere to go by itself and indicate using a single or double vibration
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentWorkoutName: UIBarButtonItem!
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var repIncrease: UIButton!
    @IBOutlet weak var repDecrease: UIButton!
    @IBOutlet weak var weightDecrease: UIButton!
    @IBOutlet weak var weightIncrease: UIButton!
    @IBOutlet weak var repCounter: UILabel!
    @IBOutlet weak var weightCounter: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    //RED:F66451
    let RED = UIColor(red: 246/255, green: 100/255, blue: 81/255, alpha: 255/255)
    //GREEN:42E287
    let GREEN = UIColor(red: 66/255, green: 226/255, blue: 135/255, alpha: 255/255)
    
    //Default values for current workout
    private var repCount: Int?
    private var weightCount: Int?
    private var setCount = 0
    private var seconds: Double = 0
    private var timer = Timer()
    private var isWorkoutComplete = false
    private var isWorkoutActive = false
    private var isWorkoutStarted = false
    
    var hex2: UIView?
    var modelExcercise: Excercise?
    
    @IBAction func startWorkout(_ sender: Any) {
        if(isWorkoutComplete){
            popVC()
            return
        }
        if(!isWorkoutStarted){
            startWorkout()
            return
        }
        if (!isWorkoutActive){
            startNextSet()
            return
        }
        if(isWorkoutActive){
            startBreak()
            return
        }
    }
    
    func startWorkout(){
        configBreakButton()
        //timerText.text = "90"
        isWorkoutStarted = true
        isWorkoutActive = true
    }
    
    func startNextSet(){
        timer.invalidate()
        configBreakButton()
        //timerText.text = "90"
        isWorkoutActive = true
        incrementSets()
    }
    
    func startBreak(){
        runBreakTimer()
        configStartButton()
        isWorkoutActive = false
    }
    
    func incrementSets(){
        setCount += 1
        let sets = modelExcercise?.sets?.count
        let setsText = modelExcercise?.sets?.count.description ?? "NA"
        //setCounter.text = "\(setCount)/\(setsText)"
        if(setCount == sets){
            configWorkoutComplete()
        }
    }
    
    func runBreakTimer(){
        timer.invalidate()
        seconds = 90
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    func updateBreakTimer(){
        if(seconds == 0){
            startNextSet()
            return
        }
        seconds -= 1
        //timerText.text = "\(Int(seconds))"
    }
    
    func configWorkoutComplete(){
        isWorkoutComplete = true
        startButton.backgroundColor = UIColor.darkGray
        startButton.setTitle("Done", for: .normal)
    }
    
    func configBreakButton(){
        startButton.backgroundColor = RED
        startButton.setTitle("Break", for: .normal)
    }
    
    func configStartButton(){
        startButton.backgroundColor = GREEN
        startButton.setTitle("Start", for: .normal)
    }
    
    
    //TODO: these actions all need to work if you hold down (modify gesture)
    @IBAction func repDecreaseAction(_ sender: Any) {
        guard let reps = repCount else {
            return
        }
        repCount = reps - 1
        repCounter.text = repCount?.description
    }
    
    @IBAction func repIncreaseAction(_ sender: Any) {
        guard let reps = repCount else {
            return
        }
        repCount = reps + 1
        repCounter.text = repCount?.description
    }
    
    @IBAction func weightDecAction(_ sender: Any) {
        guard let weight = weightCount else {
            return
        }
        weightCount = weight - 5
        weightCounter.text = weightCount?.description
    }
    
    @IBAction func weightIncAction(_ sender: Any) {
        guard let weight = weightCount else {
            return
        }
        weightCount = weight + 5
        weightCounter.text = weightCount?.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Need to do a better job of calculating these positions so it works well with various devices
        UIView.animate(withDuration: 0.5, animations: {
            var point = self.view.center
            point.y = 300
            self.hex2?.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            self.hex2?.center = point
        })
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup circle views---
        repDecrease.circleView()
        repIncrease.circleView()
        repCounter.circleView()
        weightDecrease.circleView()
        weightIncrease.circleView()
        weightCounter.circleView()
        //---
        
        //Setup back arrow---
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "left-arrow")
        imageView.image = image
        let gestures = UITapGestureRecognizer(target: self, action: #selector(popVC))
        imageView.addGestureRecognizer(gestures)
        backItem.customView = imageView
        //---
        
        collectionView.register(UINib.init(nibName: "HexCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hexCell")
        
        
        //setup data for view---
        currentWorkoutName.title = modelExcercise?.name
            //setup sets
        let sets =  modelExcercise?.sets?.count.description ?? "NA"
        //setCounter.text = "0/" + sets
        
            //setup reps
        repCount = modelExcercise?.sets?[0].reps
        let reps = repCount?.description ?? "N/A"
        repCounter.text = reps
            //setup weight
        weightCount = modelExcercise?.sets?[0].weight
        let weight = weightCount?.description ?? "N/A"
        weightCounter.text = weight
        //---
    }
    
    func hexSubView(){
        let rect = CGRect(x: 100, y: 100, width: 100, height: 100)
        hex2 = Bundle.main.loadNibNamed("HexagonView", owner: self, options: nil)?[0] as! UIImageView
        hex2?.frame = rect
        self.view.addSubview(hex2!)
    }
    
    func popVC(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension ExcerciseViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension ExcerciseViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hexCell", for: indexPath)
        return cell
    }
}

extension UIView{
    
    //Rounds UIView corners with a cornerRadius of 10.0
    func circleView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2.0
    }
}
