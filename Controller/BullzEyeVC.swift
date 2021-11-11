//
//  ViewController.swift
//  BullzEye App-ProjectTaskSession 14 LVL 2
//
//  Created by abdurhman elbosaty on 14/08/2021.
//

import UIKit

class BullzEyeVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var targetLblOutlet: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var roundValueOutlet: UILabel!
    @IBOutlet weak var scoreValueOutlet: UILabel!
    
    //MARK: - Variables
    var target = 0
    var round = 1
    var totalScore = 0
    var currentScore = 0
    var currentValue = 0
    var difference = 0
    var status = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        open()
        setUpUI()
        getRandomNum()
    }


    //MARK: - IBActions
    @IBAction func hitMeBtnPressed(_ sender: UIButton) {
        calcDifference()
        popUpAlert()
    }
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        reset()
    }
    @IBAction func infoBtnPressed(_ sender: Any) {
        let infoVC = storyboard?.instantiateViewController(identifier: "InfoVC") as! InfoVC
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .flipHorizontal
        present(infoVC, animated: true, completion: nil)
    }
    
    
    //MARK: - Helper Functions
    func setUpUI(){
        // Slider UI
        sliderOutlet.value = 50
        
        sliderOutlet.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        sliderOutlet.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)

        let uiEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let minImg = #imageLiteral(resourceName: "SliderTrackLeft").resizableImage(withCapInsets: uiEdgeInsets)
        sliderOutlet.setMinimumTrackImage(minImg, for: .normal)
        
        let maxImg = #imageLiteral(resourceName: "SliderTrackRight").resizableImage(withCapInsets: uiEdgeInsets)
        sliderOutlet.setMaximumTrackImage(maxImg, for: .normal)
        
        // Outlets UI
        roundValueOutlet.text = "\(round)"
        scoreValueOutlet.text = "\(totalScore)"
    }
    
    func getRandomNum(){
        target = Int.random(in: 2...99)
        targetLblOutlet.text = "\(target)"
    }
    
    func reset(){
        sliderOutlet.value = 50
        getRandomNum()
        round = 1
        roundValueOutlet.text = "\(round)"
        totalScore = 0
        scoreValueOutlet.text = "\(totalScore)"
        
        UserDefaults.standard.set(totalScore, forKey: "TOTAL_SCORE")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(round, forKey: "ROUND")
        UserDefaults.standard.synchronize()
    }
    
    func getSliderValue(){
        currentValue = Int(sliderOutlet.value.rounded())
    }
    func calcDifference(){
        getSliderValue()
        difference = target > currentValue ? target - currentValue : currentValue - target
        
//        if difference == 0 {
//            currentScore = 200
//            totalScore += currentScore
//            status = "Perfect"
//        }else if difference < 3{
//            currentScore = 100
//            totalScore += currentScore
//            status = "Very Good"
//        }else if difference < 5{
//            currentScore = 50
//            totalScore += currentScore
//            status = "Good"
//        }else if difference < 10{
//            currentScore = 10
//            totalScore += currentScore
//            status = "Not Bad"
//        }else{
//            currentScore = 0
//            totalScore += currentScore
//            status = "Good Luck"
//        }
        
        switch difference {
        case 0:
            currentScore = 200
            totalScore += currentScore
            status = "Perfect"
        case 0...3:
            currentScore = 100
            totalScore += currentScore
            status = "Very Good"
        case 4...5:
            currentScore = 50
            totalScore += currentScore
            status = "Good"
        case 6...10:
            currentScore = 10
            totalScore += currentScore
            status = "Not Bad"
        default:
            currentScore = 0
            totalScore += currentScore
            status = "Good Luck"
        }
        
        scoreValueOutlet.text = "\(totalScore)"
        UserDefaults.standard.set(totalScore, forKey: "TOTAL_SCORE")
        UserDefaults.standard.synchronize()
    }
    func newRound(){
        round += 1
        roundValueOutlet.text = "\(round)"
        UserDefaults.standard.set(round, forKey: "ROUND")
        UserDefaults.standard.synchronize()
    }
    func popUpAlert(){
        
        let alert = UIAlertController(title: status, message: "Your Target = \(target) \n Your Value = \(currentValue) \n Your differnce = \(difference) \n Your score = \(currentScore) \n", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.getRandomNum()
            self.newRound()
            self.sliderOutlet.value = 50
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func open(){
        
        totalScore = UserDefaults.standard.integer(forKey: "TOTAL_SCORE")
        scoreValueOutlet.text = "\(totalScore)"

        round = UserDefaults.standard.integer(forKey: "ROUND")
        roundValueOutlet.text = "\(round)"
    }
}

