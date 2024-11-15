import UIKit

class GadgetDetailViewController: UIViewController {

    @IBOutlet weak var tableDetails: UITableView!
    
    var gadget: Equipment?
    
    // Properties to receive data
    var gadgetNameText: String?
    var gadgetImage: UIImage?
    var gadgetDescriptionText: String?
    
    private func initializeCustomCell(){
        tableDetails.register(UINib(nibName: "ImageTableViewCell", bundle: .main), forCellReuseIdentifier: "imageTableViewCell")
        
        tableDetails.register(UINib(nibName: "TextTableViewCell", bundle: .main), forCellReuseIdentifier: "textTableViewCell")
    }
    
    private func cellIdentifier(for indexPath: IndexPath) -> String {
        if indexPath.row == 0 {
            return "imageTableViewCell"
        } else if indexPath.row == 1 {
            return "textTableViewCell"
        } else {
            return "textTableViewCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableDetails.dataSource = self

        setupUI()
        displayGadgetDetails()
        
        initializeCustomCell()
        tableDetails.separatorStyle = .none // Remove separator line
    }
    
    
    private func setupUI() {
        view.backgroundColor = .white
        // Configura el diseño de la UI aquí (por ejemplo, un UILabel y UIImageView para mostrar los detalles)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func displayGadgetDetails() {
        guard let gadget = gadget else { return }
        gadgetNameText = gadget.name
        gadgetImage = UIImage(named: gadget.imageURL)
        gadgetDescriptionText = gadget.description
    }
}



extension GadgetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ?  316 : UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cellIdentifier(for: indexPath)
        
        if indexPath.row == 0 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ImageTableViewCell
            imageCell.imageCustom?.image = gadgetImage
            imageCell.selectionStyle = .none
            return imageCell
        } else if indexPath.row == 1 {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            nameCell.textCustom?.text = gadgetNameText
            nameCell.textCustom.textAlignment = .center // Center the text
            nameCell.textCustom.font = UIFont.systemFont(ofSize: 24, weight: .bold) // Change the font size of the text
            nameCell.selectionStyle = .none
            return nameCell
        } else {
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTableViewCell
            descriptionCell.textCustom?.text = nil
            descriptionCell.textCustom?.text = gadgetDescriptionText
            descriptionCell.selectionStyle = .none
            return descriptionCell
        }
    }
}


