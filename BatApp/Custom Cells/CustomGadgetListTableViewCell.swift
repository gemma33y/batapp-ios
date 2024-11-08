//
//  CustomGadgetListTableViewCell.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 29/10/24.
//

import UIKit

protocol CustomGadgetListTableViewCellDelegate: AnyObject {
    func didSelectGadget(_ gadget: Equipment)
}

class CustomGadgetListTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    weak var delegate: CustomGadgetListTableViewCellDelegate?

   
    let gadgets: [Equipment] = [
        Equipment(
            name: "Acetylene Torch",
            description: "An Acetylene Torch was one of Batman's tools. It was often employed to cut through tough metal objects such as steel chains.",
            imageURL: "AcetyleneTorch"),
        Equipment(
            name: "Adrenaline Shot",
            description: "An Adrenaline Shot was kept on Batman's Utility Belt. Containing Epinephrine, the vigilante would use it to give either himself and/or other more adrenaline in emergency situations. A special injector was hidden on the Batsuit to deliver the drug quickly into Batman's body.",
            imageURL: "AdrenalineShot"),
        Equipment(
            name: "Batarangs",
            description: "Batarangs are bat-shaped throwing weapons used by Batman. These are the most basic and commonly used items in his arsenal. A vast array sizes and types have been designed, some of them razor sharp. Traditionally they are large blunt boomerangs used to knock thugs out. They can also be used as grappling hooks when attached to Batropes. Batman has also been known to use batarangs modified with additional tools and gadgets.",
            imageURL: "Batarang"),
        Equipment(
            name: "Batclaw",
            description: "The Batclaw was an attachment for Batman's grapnel gun. A clamp-based tool which could be attached to the grapnel's wire, it was used to latch onto objects and pull them towards Batman. The Batclaw was often used as both a combat tool or create maneuverability options. The Batclaw was also used by Nightwing, Batgirl and Azrael.",
            imageURL: "Batclaw"),
        Equipment(
            name: "Bat-Darts",
            description: "Bat-Darts are hand-thrown knockout darts Batman carries in his Utility Belt.",
            imageURL: "BatDarts"),
        Equipment(
            name: "Bat-Heater",
            description: "The Bat-Heater was a small heating device used by Batman during the final battle with Mr. Freeze. It is designed to thaw anyone frozen in ice. When activated, the heater's Bat-symbols pulsate with red-hot light.",
            imageURL: "BatHeater"),
        Equipment(
            name: "Bat-Laser",
            description: "Bat-Lasers are the handheld weapons used by Batman, Robin and Batgirl during their battle with Mr. Freeze, Poison Ivy and Bane.",
            imageURL: "BatLaser"),
        Equipment(
            name: "Batpoon",
            description: "The Batpoon was a small Grappling Hook used by Batman and Robin. Created in the Dynamic Duo's early days, they could attach these to their Silken Cords, rather than the conventional method of attaching a Batarang to climb or swing over to objects. The Batpoon hooks were used in more dire situations when they needed a more secure line to escape danger. Batman later developed a Batpoon Launcher, a small pistol that fit into his Utility Belt that could fire the Batpoon hook like a harpoon gun. The pistol variation was only used once.",
            imageURL: "Batpoon"),
        Equipment(
            name: "Bat-Shuriken",
            description: "Bat-Shuriken are small razors thrown by Batman, usually to disarm an opponent by flinging them at an enemy's forearm. They are the modern alternative to the traditional large folding-Batarangs. Bat-Shuriken are instantly recognizable as Batman usually holds three of the between his fingers, also using them during melee combat. Sometimes they are coated with poison to knockout or frighten thugs.",
            imageURL: "Bat-Shuriken"),
        Equipment(
            name: "Utility Belt",
            description: "The Utility Belt is the iconic storage device used to carry most of Bruce Wayne's gadgets and equipment over his Batsuit. Often depicted as part of the Bat-Family members' costumes, it is used to house various equipment for the heroes to use or access at short notice. The exact contents of this belt are not known and Batman usually changes them to suit his needs. In some stories, his enemies have attempted to steal or replicate the utility belt, believing it will give them an advantage over him.",
            imageURL: "UtilityBelt"
        ),
        Equipment(
            name: "Grapple Gun",
            description: "Grapple Guns are hi-tech pistols that fire small Grappling Hooks fitted on high-tensile wire. They are often used to scale buildings and swing to areas from long distances. They can also be used to offensively to pull enemies or object towards the user. Variations of the grapple guns have used constantly by Batman and the rest of the Bat-Family since the 1990s, though prototypes have been frequently appeared throughout comic history.",
            imageURL: "GrappleGun"
        ),
    ]
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("CustomGadget: awakeFromNib")
        collectionView.dataSource = self
        collectionView.delegate = self
        initializeCustomCells();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initializeCustomCells() {
        collectionView.register(UINib(nibName: "CustomGadgetCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "customGadgetCollectionViewCell")
    }
    
}


extension CustomGadgetListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gadgets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customGadgetCollectionViewCell", for: indexPath) as! CustomGadgetCollectionViewCell
        
        
        let gadget = gadgets[indexPath.row]
        
        print("Configuring gadget: \(gadget.name)") // Debug print

        
        cell.gadgetName?.text = gadget.name
        cell.gadgetImage?.image = UIImage(named: gadget.imageURL)
        
        return cell
    }
}


extension CustomGadgetListTableViewCell: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 150, height: 120)
   }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGadget = gadgets[indexPath.row]
        delegate?.didSelectGadget(selectedGadget)
    }
    
}
