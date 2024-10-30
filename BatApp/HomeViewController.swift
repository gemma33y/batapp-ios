//
//  HomeViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 18/10/24.
//

import UIKit

class HomeViewController: UIViewController {
    struct Enemy {
        let name: String
        let imageURL: String
        let description: String
    }
 
    
    let enemies: [Enemy] = [
        Enemy(
            name: "Bane",
            imageURL: "Bane",
            description: "The international masked criminal known as Bane has immense strength derived from a super-steroid called Venom. Bane's raw power, coupled with his genius-level intellect, makes him a considerable threat to Batman, having once succeeded in breaking Batman's back."
        ),
        Enemy(
            name: "Black Mask",
            imageURL: "BlackMask",
            description: "Roman Sionis is a corrupt businessman and crime lord who has a fixation with masks. He wears a black skull-like mask that gives him limited mind control abilities."
        ),
        Enemy(
            name: "Catwoman",
            imageURL: "Catwoman",
            description: "Selina Kyle is an accomplished jewel thief. Although traditionally considered a villain, she is often portrayed as an antihero and is occasionally romantically involved with Batman."
        ),
        Enemy(
            name: "Clayface",
            imageURL: "Clayface",
            description: "Actor Basil Karlo went mad when he learned that there would be a remake of one of his films with another actor in the lead role. Adopting the alias of the film's villain, 'Clayface', he attacked several of the remake's cast and crew at the points in filming when they were supposed to die before being stopped by Batman and Robin."
        ),
        Enemy(
            name: "Deadshot",
            imageURL: "Deadshot",
            description: "Floyd Lawton is an excellent sniper assassin who, when wielding a gun or projectile, never misses a shot."
        ),
        Enemy(
            name: "Firefly",
            imageURL: "Firefly",
            description: "Garfield Lynns is an orphan who became a pyromaniac, having developed a fireproof suit with a flamethrower to further pursue his 'hobby'."
        ),
        Enemy(
            name: "Harley Quinn",
            imageURL: "HarleyQuinn",
            description: "Dr. Harleen Quinzel was the Joker's psychiatrist at Arkham Asylum until she fell in love with him and subsequently reinvented herself as his madcap sidekick, Harley Quinn."
        ),
        Enemy(
            name: "Hugo Strange",
            imageURL: "HugoStrange",
            description: "Hugo Strange is an insane psychologist who uses his mastery of chemistry to create a serum that turns his victims into mindless monsters who obey his every command."
        ),
        Enemy(
            name: "Hush",
            imageURL: "Hush",
            description: "Dr. Thomas Elliot is a brilliant surgeon who targets both Bruce Wayne, his childhood friend, and Batman."
        ),
        Enemy(
            name: "Joker",
            imageURL: "Joker",
            description: "The Joker is a homicidal maniac with a clown-like appearance, bent on creating havoc in Gotham City and fighting a never-ending battle against Batman."
        ),
        Enemy(
            name: "Killer Croc",
            imageURL: "KillerCroc",
            description: "Waylon Jones has a medical condition that warped his body into a massive crocodile-like form. He possesses super-strength and is immune to toxins."
        ),
        Enemy(
            name: "Mad Hatter",
            imageURL: "MadHatter",
            description: "Jervis Tetch is inspired by Alice's Adventures in Wonderland to commit crimes. He uses his mind control technology to bend people to his will."
        ),
        Enemy(
            name: "Man-Bat",
            imageURL: "Man-Bat",
            description: "Dr. Kirk Langstrom invented a serum to give him echolocation in an attempt to cure his deafness. The serum had an unforeseen side effect, transforming him into the monstrous human-bat hybrid creature known as the Man-Bat."
        ),
        Enemy(
            name: "Mr. Freeze",
            imageURL: "Mr.Freeze",
            description: "Dr. Victor Fries is a scientist who accidentally spilled cryogenic chemicals on himself while inventing a freeze-gun. Now requiring subzero temperatures to survive, he uses a special containment suit and cold-themed weaponry to commit crimes."
        ),
        Enemy(
            name: "Penguin",
            imageURL: "Penguin",
            description: "Oswald Chesterfield Cobblepot is a devious, short-statured, penguin-themed crime boss who is seldom seen without at least one of his trick umbrellas. The Penguin uses his nightclub, the Iceberg Lounge, as a front for his criminal activities. He is one of Batman's few adversaries who is sane and in full control of his actions. Riddler is one of his partnerships."
        ),
        Enemy(
            name: "Poison Ivy",
            imageURL: "PoisonIvy",
            description: "Pamela Lillian Isley, a former student of advanced botanical biochemistry, employs plants of all varieties and their derivatives in her crimes."
        ),
        Enemy(
            name: "Ra's al Ghul",
            imageURL: "RaSalGhul",
            description: "Ra's al Ghul is a centuries-old international radical environmentalist who believes that his actions help 'bring balance' to the world. He is the founder of the League of Assassins and is fully aware of Batman's secret identity."
        ),
        Enemy(
            name: "Riddler",
            imageURL: "Riddler",
            description: "Edward Nashton, a.k.a. Edward Nygma, is a criminal mastermind who has a compulsion to challenge Batman by leaving clues to his crimes in the form of riddles, puzzles, and word games."
        ),
        Enemy(
            name: "Scarecrow",
            imageURL: "Scarecrow",
            description: "Professor Jonathan Crane was an outcast in childhood due to constant bullying. He now dresses symbolically as a scarecrow and employs a toxin that causes its victims to hallucinate into seeing what they fear the most."
        ),
        Enemy(
            name: "Two-Face",
            imageURL: "Two-Face",
            description: "Harvey Dent was a Gotham City district attorney until half of his face was disfigured by acid. He developed dissociative identity disorder and is obsessed with duality, using a coin to make decisions."
        ),
        Enemy(
            name: "Ventriloquist / Scarface",
            imageURL: "Ventriloquist",
            description: "Arnold Wesker is a small, mild-mannered ventriloquist with dissociative identity disorder. He projects a criminal personality through his gangster-themed dummy, Scarface."
        ),
        Enemy(
            name: "Victor Zsasz",
            imageURL: "VictorZsasz",
            description: "Victor Zsasz is a serial killer whose modus operandi involves slitting the throats of his victims, then arranging the bodies in lifelike poses. He cuts a tally mark onto his own body for each of his victims."
        )
    ]

    
    
    @IBOutlet weak var enemiesTable: UITableView!
    
    private func initializeCustomCell(){
        enemiesTable.register(UINib(nibName: "EnemyCustomTableViewCell", bundle: .main), forCellReuseIdentifier: "enemyCustomCell")
        
        enemiesTable.register(UINib(nibName: "CustomGadgetListTableViewCell", bundle: .main), forCellReuseIdentifier: "customGadgetListCell")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromEnemiesToDetails" {

            if let destination = segue.destination as? DetailsEnemyViewController,
               let indexPath = sender as? IndexPath {  // Get the index of the enemy clicked
                
                let enemy = enemies[indexPath.row]
                
                destination.nameEnemyText = enemy.name
                destination.imageEnemyImage = UIImage(named: enemy.imageURL)
                destination.descriptionEnemyText = enemy.description
            }
        }
    }


}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : enemies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150 : 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customGadgetListCell", for: indexPath) as! CustomGadgetListTableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "enemyCustomCell", for: indexPath) as! EnemyCustomTableViewCell
            
            let enemy = enemies[indexPath.row]
            
            cell.enemyName?.text = enemy.name
            cell.enemyImage?.image = UIImage(named: enemy.imageURL)
            
            return cell
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Element Selected: \( enemies[indexPath.row])")
        
        // Create a segue to show the description of the enemy -> fromEnemiesToDetail
        performSegue(withIdentifier: "fromEnemiesToDetails", sender: indexPath)
        
    }
}
