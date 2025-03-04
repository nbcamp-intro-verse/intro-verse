import UIKit
import SnapKit
import MetalKit

final class NickViewController: UIViewController, MTKViewDelegate {
    // MARK: - View Property
    private lazy var profileView = ProfileView()
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
    
    private func setViewConstraints() {
        view.addSubview(mtkView)
        view.addSubview(profileView)
        mtkView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(mtkView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
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
