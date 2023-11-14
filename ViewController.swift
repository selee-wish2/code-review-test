import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var rows = [MyRowViewModel]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = view.bounds.size.width/2 - 5.0
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier:String(describing: CollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true


        NetworkManager.loadDeals { (models, err) in
            if let models = models {
                let rows = models.map { MyRowViewModel(with: $0) }
                rows.append(rows)
                self.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
        let row = rows[indexPath.row] as! MyRowViewModel
        if indexPath.row == 0 {
            cell.label.text = "I AM FIRST"
            cell.label.font = UIFont(name: "HelveticaNeue",size: 20.0)
            cell.label.textColor = .red
        } else if indexPath.row == 1 {
            cell.label.text = row.title + " " + ".."
            cell.label.font = UIFont(name: "HelveticaNeue",size: 5.0)
            cell.label.textColor = .red
        } else {
            cell.label.text = row.title
            cell.label.textColor = .white
        }
        

        return cell
    }
}
