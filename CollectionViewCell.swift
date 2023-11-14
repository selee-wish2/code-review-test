import UIKit

class CollectionViewCell: UICollectionViewCell {
    var label = UILabel()
    var timer: Timer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.backgroundColor = .red
        label.textColor = .white
        label.text = "wish"
        contentView.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -24).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        timer = Timer.scheduledTimer(
            timeInterval: 5.0,
            target: self,
            selector: #selector(stopTimer),
            userInfo: nil,
            repeats: true
        )

        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func stopTimer() {
        label.text = "Time Up!"
    }
}


