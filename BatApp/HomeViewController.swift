//
//  HomeViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 18/10/24.
//

import UIKit

class HomeViewController: UIViewController {

    public var email: String?

    
    @IBOutlet weak var greetingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home: viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Home: viewWillAppear")

        greetingLabel.text = "Hello " + (email ?? "no email") + "!"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Home: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Home: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Home: viewDidDisappear")
    }
    
    deinit {
        print("Home: deinit")
    }

}
