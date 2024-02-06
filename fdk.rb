require "language/node"

class Fdk < Formula
  desc "Freshworks Developer Kit"
  license "MIT"
  homepage "https://developer.freshworks.com/"
 
  url "https://nodejs.org/dist/v18.18.2/node-v18.18.2-darwin-x64.tar.gz"
  sha256 "5bb8da908ed590e256a69bf2862238c8a67bc4600119f2f7721ca18a7c810c0f"

  
  # Define the resource
  resource "node" do
    url "https://nodejs.org/dist/v18.18.2/node-v18.18.2-darwin-x64.tar.gz"
    sha256 "5bb8da908ed590e256a69bf2862238c8a67bc4600119f2f7721ca18a7c810c0f" 
  end


  def install
    target_dir = prefix/"custom_node_location" 

    resource("node").stage do
      target_dir.install Dir["*"]
      ohai "Node.js installed to #{target_dir}"
    end

    ENV.prepend_path "PATH", "#{prefix}/custom_node_location/bin"
    node_version_output = Utils.safe_popen_read("node", "--version").strip
   
    ohai "Node.js version: #{node_version_output}"

    node_version_output = Utils.safe_popen_read("npm", "--version").strip
  
   
    ohai "npm.js version: #{node_version_output}"

    # npm config set prefix /usr/local/Cellar/fdk/64/custom_node_location 
    system "#{prefix}/custom_node_location/bin/npm", "config", "set", "prefix", "#{prefix}/custom_node_location"
    system "#{prefix}/custom_node_location/bin/npm", "install", "-g", "https://cdn.freshdev.io/fdk/latest.tgz"


    # home_dir = Dir.home

    # # Path to the file you want to create under the home directory
    # file_path = "~/fdklocal.zshrc"

    # ohai file_path
    # # Content you want to write to the file
    # file_content = <<~EOS
    #      export PATH="#{prefix}custom_node_location/bin:$PATH"  
    
    # EOS

    # # Open the file in write mode and write the content
    # File.open(file_path, "w") do |file| 
    #   file.write(file_content) 
    # end


  end

  test do
    system true
  end
end
