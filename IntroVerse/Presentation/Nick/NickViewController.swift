import UIKit
import SnapKit
import MetalKit

final class NickViewController: UIViewController, MTKViewDelegate {
    // MARK: - View Property
    private lazy var profileView = ProfileView()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "How to make pixel prettier ?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .fira(size: 18, weight: .semibold)
        return label
    }()
    
    private lazy var flippableCardViews: [FlippableCardView] = {
        return (0..<2).map { _ in FlippableCardView() }
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: flippableCardViews)
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Rendering Property
    var mtkView: MTKView!
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var renderer: Renderer!
    
    lazy var vertexDescriptor: MDLVertexDescriptor = {
        let vertexDescriptor = MDLVertexDescriptor()
        vertexDescriptor.vertexAttributes[0].name = MDLVertexAttributePosition
        vertexDescriptor.vertexAttributes[0].format = .float3
        vertexDescriptor.vertexAttributes[0].offset = 0
        vertexDescriptor.vertexAttributes[0].bufferIndex = 0
        vertexDescriptor.vertexAttributes[1].name = MDLVertexAttributeNormal
        vertexDescriptor.vertexAttributes[1].format = .float3
        vertexDescriptor.vertexAttributes[1].offset = MemoryLayout<Float>.size * 3
        vertexDescriptor.vertexAttributes[1].bufferIndex = 0
        vertexDescriptor.bufferLayout[0].stride = MemoryLayout<Float>.size * 6
        return vertexDescriptor
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupMTKView()
        setupStackViewGesture()
        setupFlappableViews()
        setViewConstraints()
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [
                UIColor(red: 0.27, green: 0.09, blue: 0.27, alpha: 1.0).cgColor, // #461846
                UIColor(red: 0.06, green: 0.06, blue: 0.48, alpha: 1.0).cgColor  // #10107A
            ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // far left in middle
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)   // far right in middle
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupFlappableViews() {
        let cardConfiguration: [(image: String, frontText: String, backText: String)] = [
            ("front_1", "My Interests", "I enjoy reading books and playing guitar in my free time"),
            ("front_2", "Travel Experience",
             "I have traveled to many contries, including the USA, New Zealand, Germany, Austria, Austrailia, Canada, and Japan")
        ]
        
        zip(flippableCardViews, cardConfiguration).forEach {
            cardView, config in
            guard let image = UIImage(named: config.image) else {
                assertionFailure("Failed to load image for card: \(config.image)")
                return
            }
            
            cardView.configure(with: image, frontText: config.frontText, backText: config.backText)
        }
    }
    
    private func setViewConstraints() {
        view.addSubview(mtkView)
        view.addSubview(profileView)
        view.addSubview(label)
        view.addSubview(stackView)
        
        mtkView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(mtkView.snp.bottom)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.equalToSuperview().inset(11)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.bottom.equalTo(view.snp.bottom).inset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupStackViewGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStackViewTap(_ :)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delaysTouchesBegan = false
        stackView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleStackViewTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: stackView)
        for (_, cardView) in stackView.arrangedSubviews.enumerated() {
            if cardView.frame.contains(location) {
                if let flippableCard = cardView as? FlippableCardView {
                    flippableCard.flipCard()
                }
                break;
            }
        }
    }
    
    private func setupMTKView() {
        // Mark: - Rendererr
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue() else { return print("Failed")}
        self.device = device
        self.commandQueue = commandQueue
        
        mtkView = MTKView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4), device: device)
        mtkView.device = device
        mtkView.colorPixelFormat = .bgra8Unorm_srgb
        mtkView.depthStencilPixelFormat = .depth32Float
        mtkView.delegate = self
        
        do {
            renderer = try Renderer(view: mtkView, vertexDescriptor: vertexDescriptor)
        } catch {
            handleRenderError(error)
        }
    }
        
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // no size changed
    }
    
    func draw(in view: MTKView) {
        guard let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else { return }
        
        let current_time = Float(CACurrentMediaTime())
        renderer.draw(in: view, in: renderCommandEncoder, time: current_time)
        
        renderCommandEncoder.endEncoding()
        if let drawable = view.currentDrawable {
            commandBuffer.present(drawable)
        }
        
        commandBuffer.commit()
    }
    
    private func handleRenderError(_ error: Error) {
        _ = "Unexpected error during renderer initialization: \(error.localizedDescription)"
        showErrorAlert(message: "An unexpected error occurred. Please try again.")
    }
    
    private func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Rendering Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
