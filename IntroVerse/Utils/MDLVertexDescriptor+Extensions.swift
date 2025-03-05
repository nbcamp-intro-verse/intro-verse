import ModelIO

extension MDLVertexDescriptor {
    var vertexAttributes: [MDLVertexAttribute] {
        return attributes as! [MDLVertexAttribute]
    }
    
    var bufferLayout: [MDLVertexBufferLayout] {
        return layouts as! [MDLVertexBufferLayout]
    }
}
