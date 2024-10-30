//
//  CustomGadgetListTableViewCell.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 29/10/24.
//

import UIKit

class CustomGadgetListTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    struct Equipment {
        let name: String
        let imageURL: String
        let description: String
    }
    
    let gadgets: [Equipment] = [
        Equipment(name: "Batarang", imageURL: "Batarang", description: "Prova"),
        Equipment(name: "Batclaw", imageURL: "Batclaw", description: "Prova"),
        Equipment(name: "Batman's Pistol", imageURL: "BatmansPistol", description: "Prova"),
        Equipment(name: "Batzooka", imageURL: "Batzooka", description: "Prova"),
        Equipment(name: "Cryptographic Sequencer", imageURL: "CryptographicSequencer", description: "Prova"),
        Equipment(name: "Detective Mode", imageURL: "DetectiveMode", description: "Prova"),
        Equipment(name: "Grapple Gun", imageURL: "GrappleGun", description: "Prova"),
        Equipment(name: "Harpoon Rifle", imageURL: "HarpoonRifle", description: "Prova"),
        Equipment(name: "Line Launcher", imageURL: "LineLauncher", description: "Prova"),
        Equipment(name: "Memory Cloth Cape", imageURL: "MemoryClothCape", description: "Prova"),
        Equipment(name: "Smoke Bomb", imageURL: "SmokeBomb", description: "Prova"),
        Equipment(name: "Sticky Bomb Gun", imageURL: "StickyBombGun", description: "Prova"),
        Equipment(name: "Tactical Knife", imageURL: "TacticalKnife", description: "Prova"),
        Equipment(name: "Utility Belt", imageURL: "UtilityBelt", description: "Prova")
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
}
