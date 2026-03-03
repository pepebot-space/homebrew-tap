class Pepebot < Formula
  desc "Ultra-lightweight personal AI agent"
  homepage "https://github.com/pepebot-space/pepebot"
  version "0.5.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-darwin-arm64.tar.gz"
      sha256 "62cf069475aec6fe9fd7662c3e7512cccee07b6e6a5d2871eb710568c2592b6c" # Will be filled with actual checksum
    else
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-darwin-amd64.tar.gz"
      sha256 "473cdd779a278aecdcdc5466a35b21a792af27085bd8a49da30789ca06217508" # Will be filled with actual checksum
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-arm64.tar.gz"
        sha256 "125721d33d048a35884ed5eaf79986ac621e38e5d1e633315bc56b86d0157d67" # Will be filled with actual checksum
      else
        url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-armv7.tar.gz"
        sha256 "8374a455dc9b8ef557f2bd7c7cc6cf5900146f1825e36a038e52d58c07839229" # Will be filled with actual checksum
      end
    else
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-amd64.tar.gz"
      sha256 "57bcf9854e4a75e9c19a2f2a388c020ae07eeb5b10a1f30b29879ad67f73fb6d" # Will be filled with actual checksum
    end
  end

  def install
    bin.install "pepebot-darwin-arm64" => "pepebot" if OS.mac? && Hardware::CPU.arm?
    bin.install "pepebot-darwin-amd64" => "pepebot" if OS.mac? && Hardware::CPU.intel?
    bin.install "pepebot-linux-arm64" => "pepebot" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    bin.install "pepebot-linux-armv7" => "pepebot" if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    bin.install "pepebot-linux-amd64" => "pepebot" if OS.linux? && Hardware::CPU.intel?
  end

  def caveats
    <<~EOS
      Pepebot has been installed!

      To get started:
        1. Run the setup wizard:
           pepebot onboard

        2. Start interactive mode:
           pepebot agent

        3. Or start the gateway:
           pepebot gateway

      Configuration: ~/.pepebot/config.json
      Workspace: ~/.pepebot/workspace/

      For more information:
        https://github.com/pepebot-space/pepebot
    EOS
  end

  service do
    run [opt_bin/"pepebot", "gateway"]
    keep_alive true
    working_dir var/"pepebot"
    log_path var/"log/pepebot.log"
    error_log_path var/"log/pepebot.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pepebot version")
  end
end
