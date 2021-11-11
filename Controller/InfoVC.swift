//
//  InfoVC.swift
//  BullzEye App-ProjectTaskSession 14 LVL 2
//
//  Created by abdurhman elbosaty on 14/08/2021.
//

import UIKit
import WebKit

class InfoVC: UIViewController {

    
    @IBOutlet weak var webKitOutlet: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }

    //MARK: - IBActions
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Helper Functions
    
    func getInfo() {
        guard let urlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html") else {return}
        let url = URL(fileURLWithPath: urlPath)
        let urlRequest = URLRequest(url: url)
        webKitOutlet.load(urlRequest)
    }
    
    
    
}
