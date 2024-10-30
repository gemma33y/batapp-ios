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
            name: "Utility Belt",
            description: "The Utility Belt is the iconic storage device used to carry most of Bruce Wayne's gadgets and equipment over his Batsuit. Often depicted as part of the Bat-Family members' costumes, it is used to house various equipment for the heroes to use or access at short notice. The exact contents of this belt are not known and Batman usually changes them to suit his needs. In some stories, his enemies have attempted to steal or replicate the utility belt, believing it will give them an advantage over him.",
            imageURL: "UtilityBelt"
        ),
        Equipment(
            name: "Grappling Gun",
            description: "Grapple Guns are hi-tech pistols that fire small Grappling Hooks fitted on high-tensile wire. They are often used to scale buildings and swing to areas from long distances. They can also be used to offensively to pull enemies or object towards the user. Variations of the grapple guns have used constantly by Batman and the rest of the Bat-Family since the 1990s, though prototypes have been frequently appeared throughout comic history.",
            imageURL: "GrapplingGun"
        ),
        Equipment(
            name: "Batarang",
            description: "Batarangs are bat-shaped throwing weapons used by Batman. These are the most basic and commonly used items in his arsenal. A vast array sizes and types have been designed, some of them razor sharp. Traditionally they are large blunt boomerangs used to knock thugs out. They can also be used as grappling hooks when attached to Batropes. Batman has also been known to use batarangs modified with additional tools and gadgets.",
            imageURL: "Batarang"
        ),
        Equipment(
            name: "Batmobile",
            description: "The Batmobile is the primary mode of transportation for Batman. The vehicle is one of the most daunting components in his vast arsenal, keeping it stored in the Batcave when not in use. The Batmobile is used by Batman to patrol Gotham City and has gone through many iterations over the years. It is equipped with a wide array of gadgets and weapons, including but not limited to the ejection seat, the Batcomputer, and the ability to transform into the Batplane.",
            imageURL: "Batmobile"
        ),
        Equipment(
            name: "Bat-Signal",
            description: "The Bat-Signal is a large searchlight with the emblem of a bat affixed to it. It is a specially modified Klieg searchlight with a stylized emblem of a bat affixed to the light. It is used by the Gotham City Police Department as a method of contacting and summoning Batman to their assistance. Though it is not always used, it is a method of contacting Batman when the city is in peril.",
            imageURL: "BatSignal"
        ),
        Equipment(
            name: "Batcomputer",
            description: "The Batcomputer is the main computer system used by Batman. It is located in the Batcave and is used by Batman to analyze evidence, communicate with allies, and access the vast resources of the Bat-Family. The Batcomputer is one of the most advanced computer systems in the world and is capable of hacking into any system, analyzing any substance, and tracking any individual.",
            imageURL: "Batcomputer"
        ),
        Equipment(
            name: "Bat-Suit",
            description: "The Bat-Suit is the iconic costume worn by Batman. It is a protective suit that is designed to help Batman fight crime and protect Gotham City. The suit is made of a high-tech material that is resistant to bullets, knives, and other weapons. It also has a built-in cape that allows Batman to glide through the air. The suit is equipped with a variety of gadgets and weapons, including but not limited to the utility belt, the grappling gun, and the batarang.",
            imageURL: "BatSuit"
        ),
        Equipment(
            name: "Batcave",
            description: "The Batcave is the secret headquarters of Batman. It is located beneath Wayne Manor and is accessed through a hidden entrance. The Batcave is equipped with a wide array of gadgets and weapons, including but not limited to the Batcomputer, the Batmobile, and the Batsuit. It also serves as a training facility for Batman and the rest of the Bat-Family.",
            imageURL: "Batcave"
        ),
        Equipment(
            name: "Bat-Signal",
            description: "The Bat-Signal is a large searchlight with the emblem of a bat affixed to it. It is a specially modified Klieg searchlight with a stylized emblem of a bat affixed to the light. It is used by the Gotham City Police Department as a method of contacting and summoning Batman to their assistance. Though it is not always used, it is a method of contacting Batman when the city is in peril.",
            imageURL: "BatSignal"
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
       return CGSize(width: 100, height: 120)
   }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGadget = gadgets[indexPath.row]
        delegate?.didSelectGadget(selectedGadget)
    }
    
}
