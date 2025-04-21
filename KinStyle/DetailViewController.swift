import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var outfitImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView! // Heart image for like button
    @IBOutlet weak var addToCartButton: UIButton!

    var selectedImage: UIImage?
    var outfitName: String?
    var outfitPrice: String?
    var outfitSize: String?
    var outfitColor: String?
    
    var isLiked = false // Track the "liked" state
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the selected image and details
        outfitImageView.image = selectedImage
        detailsLabel.text = outfitName ?? "No details available."
        priceLabel.text = "Price: \(outfitPrice ?? "N/A")"
        sizeLabel.text = "Size: \(outfitSize ?? "N/A")"
        colorLabel.text = "Color: \(outfitColor ?? "N/A")"
        
        // Set up the back button programmatically
        setupBackButton()
        
        // Set up the heart image for like functionality
        setupHeartImageView()

        // Set up add to cart button
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
    }

    private func setupBackButton() {
        // Create back button
        let backButton = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.backward.circle.fill") // Use a chevron icon
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .brown
        
        // Set the button frame (position and size)
        backButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
        
        // Add target for back button
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(backButton)
    }

    private func setupHeartImageView() {
        // Enable user interaction on the heart image
        heartImageView.isUserInteractionEnabled = true
        
        // Set up the heart image (empty or filled) based on the initial state
        updateHeartImage()

        // Add tap gesture recognizer to the heart image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartImageTapped))
        heartImageView.addGestureRecognizer(tapGesture)
    }

    private func updateHeartImage() {
        // Determine which heart image to show based on the "liked" state
        let heartImageName = isLiked ? "heart_filled_icon" : "heart_icon"
        print("Attempting to load image: \(heartImageName)") // Debug: check which image is being loaded
        
        // Load the heart image from assets
        if let heartImage = UIImage(named: heartImageName) {
            heartImageView.image = heartImage
        } else {
            print("Error: Heart image not found in assets.")  // Debug: Image not found error
        }
    }

    @objc func heartImageTapped() {
        // Toggle the "liked" state
        isLiked.toggle()
        
        // Log the current liked state for debugging
        print(isLiked ? "Liked!" : "Unliked!")  // Debug: Whether the image is liked or unliked
        
        // Update the heart image when tapped
        updateHeartImage()
    }

    // Handle back button tap
    @objc func backButtonTapped() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    // Add to cart button tapped
    @objc func addToCartButtonTapped() {
        // Handle add to cart functionality here
        print("Added to Cart!")
    }
}
