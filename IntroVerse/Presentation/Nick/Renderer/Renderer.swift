import MetalKit

typealias float2 = SIMD2<Float>
typealias float3 = SIMD3<Float>
typealias float4 = SIMD4<Float>

struct FrameConstants {
    var time: Float
    var resolution: float2
}

let MaxFrameCount = 30
let ConstantBufferLength = 65_536 // 65 KB
let ConstantAlignment: Int = 256

final class Renderer: NSObject {
    let view: MTKView
    let device: MTLDevice
    let renderPipelineState: MTLRenderPipelineState
    let depthStencilState: MTLDepthStencilState
    var constantBuffers = [MTLBuffer]()
    let dummyVertexBuffer: MTLBuffer!
    var frameIndex = 0
    
    init?(view: MTKView, vertexDescriptor: MDLVertexDescriptor) throws {
        guard let device = view.device else { throw NSError(domain:"Renderer", code: -1, userInfo:nil) }
        self.device = device
        self.view = view
        view.preferredFramesPerSecond = 60
        guard let depthStencilState = Renderer.makeDepthStencilState(device: device) else { return nil }
        self.depthStencilState = depthStencilState
        
        let dummyData: [Float] = [0.0]
        dummyVertexBuffer = device.makeBuffer(bytes: dummyData, length: MemoryLayout<Float>.size, options: [])
        
        for _ in 0..<MaxFrameCount {
            guard let buffer = device.makeBuffer(length: ConstantBufferLength, options:[.storageModeShared]) else {
                return nil
            }
            constantBuffers.append(buffer)
        }
        
        do {
            renderPipelineState = try Renderer.makeRenderPipelineState(view: view, vertexDescriptor: vertexDescriptor)!
        } catch {
            return nil
        }
    }
        
    func draw(in view: MTKView, in renderCommandEncoder: MTLRenderCommandEncoder, time: Float) {
        frameIndex = (frameIndex + 1) % MaxFrameCount
        let constantBuffer = constantBuffers[frameIndex]
            
        var constants = FrameConstants(time: time,
                                           resolution: float2(Float(view.drawableSize.width), Float(view.drawableSize.height)))
            
        memcpy(constantBuffer.contents(), &constants, MemoryLayout<FrameConstants>.size)
            
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setDepthStencilState(depthStencilState)
        renderCommandEncoder.setVertexBuffer(dummyVertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentBuffer(constantBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
    }
    
    private static func makeDepthStencilState(device: MTLDevice) -> MTLDepthStencilState? {
        let depthStateDescriptor = MTLDepthStencilDescriptor()
        depthStateDescriptor.depthCompareFunction = .less
        depthStateDescriptor.isDepthWriteEnabled = true
        return device.makeDepthStencilState(descriptor: depthStateDescriptor)
    }
    
    private static func makeRenderPipelineState(view: MTKView, vertexDescriptor: MDLVertexDescriptor) throws -> MTLRenderPipelineState? {
        guard let device = view.device else { throw NSError(domain:"Renderer", code: -1, userInfo:nil) }
        guard let library = device.makeDefaultLibrary() else { throw NSError(domain: "Renderer", code: -1, userInfo: nil)}
        let vertexFunction = library.makeFunction(name: "vertex_main")
        let fragmentFunction = library.makeFunction(name: "fragment_main")
        let vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(vertexDescriptor)
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        pipelineDescriptor.rasterSampleCount = view.sampleCount
        pipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
        pipelineDescriptor.depthAttachmentPixelFormat = view.depthStencilPixelFormat
        return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
}

