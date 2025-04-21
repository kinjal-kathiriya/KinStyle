import UIKit

class BoyCelebrityOutfitsViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!

    @IBOutlet weak var cartBadgeImageView1: UIImageView!
    @IBOutlet weak var cartBadgeImageView2: UIImageView!
    @IBOutlet weak var cartBadgeImageView3: UIImageView!
    @IBOutlet weak var cartBadgeImageView4: UIImageView!
    @IBOutlet weak var cartBadgeImageView5: UIImageView!
    @IBOutlet weak var cartBadgeImageView6: UIImageView!
    @IBOutlet weak var cartBadgeImageView7: UIImageView!
    @IBOutlet weak var cartBadgeImageView8: UIImageView!
    @IBOutlet weak var cartBadgeImageView9: UIImageView!
    @IBOutlet weak var cartBadgeImageView10: UIImageView!

    let imageDetails: [(name: String, price: String, size: String, color: String)] = [
        ("Classic Beckham", "$60", "XS", "Black"),
        ("Chic Timothée", "$70", "XXS", "White"),
        ("Retro Harry", "$50", "S", "White"),
        ("Cool Evans", "$60", "XXS", "Navy Blue"),
        ("Smart Shawn", "$55", "S", "Skin"),
        ("Street Bieber", "$60", "XXS", "Brown"),
        ("Smart Shawn", "$40", "XS", "Dark green"),
        ("Relaxed Reynolds", "$60", "XS", "sky"),
        ("Edgy Zendaya", "$55", "XXS", "Blue"),
        ("Bold Rock", "$65", "XS", "Green")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestures()
        addImageTapGestures()
    }

    // Add tap gesture recognizers to cart badges
    func addTapGestures() {
        let cartBadgeImages = [
            cartBadgeImageView1, cartBadgeImageView2, cartBadgeImageView3, cartBadgeImageView4, cartBadgeImageView5,
            cartBadgeImageView6, cartBadgeImageView7, cartBadgeImageView8, cartBadgeImageView9, cartBadgeImageView10
        ]

        for (index, imageView) in cartBadgeImages.enumerated() {
            imageView?.isUserInteractionEnabled = true
            imageView?.tag = index
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cartBadgeTapped(_:)))
            imageView?.addGestureRecognizer(tapGesture)
        }
    }

    // Add tap gesture recognizers to outfit images
    func addImageTapGestures() {
        let outfitImages = [
            imageView1, imageView2, imageView3, imageView4, imageView5,
            imageView6, imageView7, imageView8, imageView9, imageView10
        ]

        for (index, imageView) in outfitImages.enumerated() {
            imageView?.isUserInteractionEnabled = true
            imageView?.tag = index
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(outfitImageTapped(_:)))
            imageView?.addGestureRecognizer(tapGesture)
        }
    }

    // Handle tapping on cart badge
    @objc func cartBadgeTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedImageView = gesture.view as? UIImageView else { return }

        let details = imageDetails[tappedImageView.tag]
        let selectedImage = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9, imageView10][tappedImageView.tag]?.image

        if let addToCartVC = storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as? AddToCartViewController {
            addToCartVC.selectedImage = selectedImage
            addToCartVC.outfitName = details.name
            addToCartVC.outfitPrice = details.price
            addToCartVC.outfitSize = details.size
            addToCartVC.outfitColor = details.color

            if let navigationController = navigationController {
                navigationController.pushViewController(addToCartVC, animated: true)
            } else {
                addToCartVC.modalPresentationStyle = .fullScreen
                present(addToCartVC, animated: true)
            }
        }
    }

    // Handle tapping on an outfit image
    @objc func outfitImageTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedImageView = gesture.view as? UIImageView else { return }

        let details = imageDetails[tappedImageView.tag]
        let selectedImage = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9, imageView10][tappedImageView.tag]?.image

        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.selectedImage = selectedImage
            detailVC.outfitName = details.name
            detailVC.outfitPrice = details.price
            detailVC.outfitSize = details.size
            detailVC.outfitColor = details.color

            if let navigationController = navigationController {
                navigationController.pushViewController(detailVC, animated: true)
            } else {
                detailVC.modalPresentationStyle = .fullScreen
                present(detailVC, animated: true)
            }
        }
    }
}
