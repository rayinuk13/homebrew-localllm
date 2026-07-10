class Localllm < Formula
  desc "Download and run LLMs locally. 98 models. More than Ollama."
  homepage "https://github.com/rayinuk13/localllm"
  url "https://github.com/rayinuk13/localllm/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "98fd2428124051b622012d938f25a99d57975da663861058d8154849e2a19870"
  license "MIT"
  version "1.1.0"

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

        localllm list                    — see all 98 models
        localllm pull llama3.1-8b        — download a model (~5GB)
        localllm run  llama3.1-8b        — run it interactively
        localllm search reasoning        — find reasoning models
        localllm list --tag thinking     — o1-style models
        localllm list --family qwen3     — filter by family

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
