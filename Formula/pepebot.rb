class Pepebot < Formula
  desc "Ultra-lightweight personal AI agent"
  homepage "https://github.com/pepebot-space/pepebot"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-darwin-arm64.tar.gz"
      sha256 "" # Will be filled with actual checksum
    else
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-darwin-amd64.tar.gz"
      sha256 "" # Will be filled with actual checksum
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-arm64.tar.gz"
        sha256 "" # Will be filled with actual checksum
      else
        url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-armv7.tar.gz"
        sha256 "" # Will be filled with actual checksum
      end
    else
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-amd64.tar.gz"
      sha256 "" # Will be filled with actual checksum
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
