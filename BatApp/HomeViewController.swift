//
//  HomeViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 18/10/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeViewController: UIViewController {
    let url: String = "https://api.batmanapi.com"
    let endpoint: String = "/v1/characters?pagination[pageSize]=80"
    
    var heroes: [Character] = []
    var villains: [Character] = []

    
    @IBOutlet weak var enemiesTable: UITableView!

    private func initializeCustomCell(){
        enemiesTable.register(UINib(nibName: "EnemyCustomTableViewCell", bundle: .main), forCellReuseIdentifier: "enemyCustomCell")
        
        enemiesTable.register(UINib(nibName: "CustomGadgetListTableViewCell", bundle: .main), forCellReuseIdentifier: "customGadgetListCell")
    }
    
    private func loadEnemies(){
        let urlGetEnemies = self.url + self.endpoint
        
        print(urlGetEnemies)
        
        AF.request(urlGetEnemies).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        print("Response: (responseString)")
                        if let data = responseString.data(using: .utf8) {
                            // Parse JSON using SwiftyJSON
                            let json = JSON(data)
                            
                            // Access the "data" array
                            let dataArray = json["data"].arrayValue
                            
                            // Loop through each item
                            for item in dataArray {
                                let attributes = item["attributes"]
                                
                                let name = attributes["name"].stringValue
                                let alias = attributes["alias"].stringValue
                                let alive = attributes["alive"].boolValue
                                let role = attributes["role"].stringValue
                                let description = attributes["description"].stringValue
                                let imageURL = attributes["image_url"].stringValue
                                
                        
                                
                                let character = Character(
                                                name: name,
                                                alias: alias,
                                                alive: alive,
                                                role: role,
                                                imageURL: imageURL.replacingOccurrences(of: "example.com", with: "batman.devitest.es"),
                                                description: description
                                            )
                                
                                if (character.role.lowercased() == "hero".lowercased()) {
                                    self.heroes.append(character)
                                } else if (character.role.lowercased().contains("villain".lowercased())) {
                                    self.villains.append(character)
                                }

                            }
                            self.enemiesTable.reloadData()
                        }
                    }
                case .failure(let error):
                    print("Error: (error)")
                }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home: viewDidLoad")
        loadEnemies()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromEnemiesToDetails" {

            if let destination = segue.destination as? DetailsEnemyViewController,
               let character = sender as? Character {  // Get the index of the enemy clicked
                
                destination.nameCharacterText = character.name
                destination.aliasCharacterText = character.alias
                destination.imageCharacterImage = character.imageURL
                destination.descriptionCharacterText = character.description
                destination.roleCharacterText = character.role
                destination.aliveCharacterText = character.alive
            }
        }
        
        if segue.identifier == "fromEnemiesToDetails" {
            if let destination = segue.destination as? DetailsEnemyViewController,
               let gadget = sender as? Equipment {
                print("Gadget: \(gadget)")
                destination.nameCharacterText = gadget.name
                destination.descriptionCharacterText = gadget.description
                destination.imageCharacterImage = gadget.imageURL
            }
        }
    }

}



extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return heroes.count
        } else {
            return villains.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150 : 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customGadgetListCell", for: indexPath) as! CustomGadgetListTableViewCell
            
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "enemyCustomCell", for: indexPath) as! EnemyCustomTableViewCell
               
               let character: Character
               if indexPath.section == 1 {
                   character = heroes[indexPath.row]
               } else {
                   character = villains[indexPath.row]
               }
               
               cell.enemyName?.text = character.alias
               cell.enemyImage?.sd_setImage(
                   with: URL(string: character.imageURL),
                   placeholderImage: UIImage(named: "batman-logo")
               )
               
               if !character.alive {
                   cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
               } else {
                   cell.backgroundColor = .white
               }
               
               return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Gadgets"
        } else if (section == 1) {
            return "Heroes"
        } else {
            return "Villains"
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCharacter: Character
        if indexPath.section == 1 {
            selectedCharacter = heroes[indexPath.row] // Section 1: Heroes
        } else {
            selectedCharacter = villains[indexPath.row] // Section 2: Villains
        }
        
        // Create a segue to show the description of the enemy -> fromEnemiesToDetail
        performSegue(withIdentifier: "fromEnemiesToDetails", sender: selectedCharacter)
        
    }
    
  
}

extension HomeViewController: CustomGadgetListTableViewCellDelegate {
    func didSelectGadget(_ gadget: Equipment) {
        performSegue(withIdentifier: "fromEnemiesToDetails", sender: gadget)
    }
}
