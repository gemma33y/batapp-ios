//
//  HomeViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 18/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var enemiesTable: UITableView!
    
    var enemies: [String] = ["Joker", "Bats", "Spiders", "lkasjflkasjflkjsalkjdaslkfjaslkdjflkasjflkasjflkasjdflkasdj"]
    
    private func initializeCustomCell(){
        enemiesTable.register(UINib(nibName: "EnemyCustomTableViewCell", bundle: .main), forCellReuseIdentifier: "enemyCustomCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home: viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Home: viewWillAppear")
        initializeCustomCell()
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


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enemies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "enemyCustomCell", for: indexPath) as! EnemyCustomTableViewCell
        
        cell.enemyName?.text = enemies[indexPath.row]
       
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Elwment Selected: \( enemies[indexPath.row])")
    }
}
