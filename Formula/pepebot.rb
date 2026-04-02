class Pepebot < Formula
  desc "Ultra-lightweight personal AI agent"
  homepage "https://github.com/pepebot-space/pepebot"
  version "0.5.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-darwin-arm64.tar.gz"
      sha256 "2883112daea2430bac40be3f694e198f54b7d7c6887069372f57e612f2bfaba9" # Will be filled with actual checksum
    else
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-darwin-amd64.tar.gz"
      sha256 "3e3883d5b2676ba067e6cb0f20f77e9cc2d281e388eb6ab59e4f57bf33cb0e74" # Will be filled with actual checksum
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-arm64.tar.gz"
        sha256 "6c13873d2d31709e3f99be2a6a7ee996f4276ab8481cad7aaff8c41d795b0f53" # Will be filled with actual checksum
      else
        url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-armv7.tar.gz"
        sha256 "6ad0810126f5d46f4820beebb24daed0e4389fca1f78a08f1b03ea775eec9787" # Will be filled with actual checksum
      end
    else
      url "https://github.com/pepebot-space/pepebot/releases/download/v#{version}/pepebot-linux-amd64.tar.gz"
      sha256 "5e8baa6356f1f6905d227cd65474659c34858ba98550605e3b22d8830b1ae203" # Will be filled with actual checksum
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
