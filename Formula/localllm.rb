class Localllm < Formula
  desc "Download and run LLMs locally. 63 models. More than Ollama."
  homepage "https://github.com/rayinuk13/localllm"
  url "https://github.com/rayinuk13/localllm/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "5007d1f022feadd51ff5587b5fbbb16d89b92153c8b515e6776919de0e782044"
  license "MIT"
  version "1.0.0"

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

        localllm list                    — see all 63 models
        localllm pull llama3.1-8b        — download a model (~5GB)
        localllm run  llama3.1-8b        — run it interactively
        localllm search reasoning        — find reasoning models

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
