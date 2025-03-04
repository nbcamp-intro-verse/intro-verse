import UIKit
import SnapKit
import MetalKit

final class NickViewController: UIViewController, MTKViewDelegate {
    // MARK: - Property
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .fira(size: 20, weight: .semibold)
        label.text = "Seungho Jang"
        return label
    }()
    
    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .fira(size: 14, weight: .medium)
        label.text = "\u{2022} Graphics Engineer"
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "nick_profile")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var githublogoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "github_logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.text = "https://github.com/sjang1594"
        label.textColor = .white
        label.font = .fira(size: 18, weight: .semibold)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var blogLogoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "nick_blog_logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.text = "https://sjang1594.github.io/"
        label.textColor = .white
        label.font = .fira(size: 18, weight: .semibold)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
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
        setupWhoAmILayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderWidth = 2
        githublogoImageView.layer.cornerRadius = githublogoImageView.frame.size.width / 2
        blogLogoImageView.layer.cornerRadius = blogLogoImageView.frame.size.width / 2
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
        view.addSubview(mtkView)
        
        do {
            renderer = try Renderer(view: mtkView, vertexDescriptor: vertexDescriptor)
        } catch {
            handleRenderError(error)
        }
        
        // Constraint
        mtkView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
    }
    
    private func setupWhoAmILayout() {
        view.addSubview(nameLabel)
        view.addSubview(roleLabel)
        view.addSubview(imageView)
        view.addSubview(githublogoImageView)
        view.addSubview(githubLabel)
        view.addSubview(blogLogoImageView)
        view.addSubview(blogLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mtkView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(mtkView.snp.bottom).offset(11)
            // -407: iphone 16 pro width + trailing position + imageView.width
            make.trailing.equalToSuperview().offset(-407 + 372)
            make.width.height.equalTo(72)
        }
        
        githublogoImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(view.frame.width * 0.125)
            make.width.height.equalTo(32)
        }
        
        githubLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(7)
            make.leading.equalTo(githublogoImageView.snp.trailing).offset(10)
        }
        
        blogLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(githublogoImageView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(view.frame.width * 0.125)
            make.width.height.equalTo(32)
        }
        
        blogLabel.snp.makeConstraints { make in
            make.top.equalTo(githubLabel.snp.bottom).offset(14)
            make.leading.equalTo(blogLogoImageView.snp.trailing).offset(10)
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
