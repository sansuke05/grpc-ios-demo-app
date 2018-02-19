Pod::Spec.new do |s|
    s.name     = 'RemoteClient'
    s.version  = '0.0.1'
    s.license  = 'MIT'
    s.authors  = { 'Watanabe' => 'takanori5064@gmail.com' }
    s.homepage = 'http://sansuke05.hatenablog.com/'
    s.summary = 'gRPC test client'
    s.source = { :git => '' }

    s.ios.deployment_target = '11.2'
    s.osx.deployment_target = '10.12'

    s.dependency "!ProtoCompiler-gRPCPlugin", "~> 1.0.0"
    
    pods_root = '../Pods'

    protoc_dir = "#{pods_root}/!ProtoCompiler"
    protoc = "#{protoc_dir}/protoc"
    plugin = "#{pods_root}/!ProtoCompiler-gRPCPlugin/grpc_objective_c_plugin"
    
    s.prepare_command = <<-CMD
        #{protoc} \
            --plugin=protoc-gen-grpc=#{plugin} \
            --objc_out=. \
            --grpc_out=. \
            -I . \
            -I #{protoc_dir} \
            *.proto
    CMD

    s.subspec 'Messages' do |ms|
        ms.source_files = '*.pbobjc.{h,m}'
        ms.header_mappings_dir = '.'
        ms.requires_arc = false
        ms.dependency 'Protobuf'

        ms.pod_target_xcconfig = {
            'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
        }
    end

    s.subspec 'Services' do |ss|
        ss.source_files = '*.pbrpc.{h,m}'
        ss.header_mappings_dir = '.'
        ss.requires_arc = true
        ss.dependency 'gRPC-ProtoRPC'
        ss.dependency "#{s.name}/Messages"
    end
end
