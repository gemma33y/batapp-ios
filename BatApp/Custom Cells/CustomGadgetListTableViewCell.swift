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
        Equipment(
            name: "Bomb",
            imageURL: "Bomb",
            description: "Prova"
            ),
        Equipment(
            name: "Bomb",
            imageURL: "Bomb",
            description: "Prova"
        ),
        Equipment(
            name: "Bomb",
            imageURL: "Bomb",
            description: "Prova"
        )
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("CustomGadget: awakeFromNib")
        collectionView.dataSource = self
        collectionView.delegate = self
        initializeCustomCells();
        self.backgroundColor = UIColor.lightGray
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
        cell.gadgetImage?.image = UIImage(named: "batman-logo")
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.green : UIColor.white

        
        return cell
    }
}

extension CustomGadgetListTableViewCell: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 100, height: 120)
   }
}
