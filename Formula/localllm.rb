class Localllm < Formula
  desc "Download and run LLMs locally. 98 models. More than Ollama."
  homepage "https://github.com/rayinuk13/localllm"
  url "https://github.com/rayinuk13/localllm/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "ec36c6f5361004ed315914fd738a8fb418281107c0bc4092afe347c0da6bad44"
  license "MIT"
  version "1.2.0"

  depends_on "llama.cpp" => :recommended
  depends_on "python3"

  def install
    libexec.install "bin/localllm.py"
    (bin/"localllm").write <<~SH
      #!/bin/sh
      exec python3 "#{libexec}/localllm.py" "$@"
    SH
    chmod 0755, bin/"localllm"
    chmod 0755, libexec/"localllm.py"
  end

  def caveats
    <<~EOS
      localllm is ready. Quick start:

        localllm list                     — 98 models with icons + RAM
        localllm pull llama3.1-8b         — animated download with live ETA
        localllm run  llama3.1-8b         — run interactively
        localllm stats                    — disk usage dashboard
        localllm search reasoning         — search with highlights
        localllm list --tag vision        — filter by capability

      llama.cpp is required to run GGUF models:
        brew install llama.cpp

      For Apple Silicon MLX models:
        pip3 install mlx-lm
    EOS
  end

  test do
    assert_match "localllm", shell_output("#{bin}/localllm 2>&1")
  end
end
