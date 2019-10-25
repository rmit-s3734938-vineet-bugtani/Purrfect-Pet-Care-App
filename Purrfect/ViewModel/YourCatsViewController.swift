
import UIKit

class YourCatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,Storyboarded {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    weak var coordinator : MainCoordinator?
    
    var myViewModel = CatsViewModel()
    
    var list : [Cat] = []

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! TableViewCell
        cell.title.text = myViewModel.getCat(index: indexPath.row).name
        cell.myDescription.text = myViewModel.getCat(index: indexPath.row).description
        let image = myViewModel.getCat(index: indexPath.row).imageName
        if image != "" {
            cell.myImage.image = UIImage(named: image)
        }
        
        cell.myImage.layer.cornerRadius = cell.myImage.frame.size.width / 2
        cell.myImage.clipsToBounds = true
        
        cell.myImage.layer.borderWidth = 3
        let brightRed = UIColor(red: 0.94, green: 0.47, blue: 0.62, alpha: 1.0)
        cell.myImage.layer.borderColor = brightRed.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      coordinator?.createDetailView(index : indexPath.row,myViewModel : myViewModel)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myViewModel.getListt().count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myViewModel.removeData(index: indexPath.row)
            myViewModel.delete(index: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    @objc func navigateToNextView(){
        coordinator?.createAddView(myViewModel: myViewModel)
    }
    
    @objc func reload(){
        myViewModel.refresh()
        list = myViewModel.getListt()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        list = myViewModel.getModel().getList()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
       
        self.navigationItem.hidesBackButton = true;
       NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reloadTheTable"), object: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToNextView))
}


    @IBOutlet weak var tableView: UITableView!
}

