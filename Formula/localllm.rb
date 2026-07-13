class Localllm < Formula
  desc "Download and run LLMs locally. 98 models + OpenAI cloud. More than Ollama."
  homepage "https://github.com/rayinuk13/localllm"
  url "https://github.com/rayinuk13/localllm/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "2d1c63f70b80cfb5ada322d99c14c867b915ebfecde057124f12f86d1a9911c4"
  license "MIT"
  version "1.3.0"

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
      localllm v1.3.0 is ready.

      Local models (98):
        localllm list
        localllm pull llama3.1-8b
        localllm run  llama3.1-8b

      OpenAI / ChatGPT:
        localllm openai key sk-…
        localllm openai run gpt-4.1-mini
        localllm openai run o4-mini

      Billing (active when cloud backend launches):
        localllm billing

      Config is stored at ~/.localllm/config.json (chmod 600).
      API keys are masked in all output and never logged.
    EOS
  end

  test do
    assert_match "localllm", shell_output("#{bin}/localllm 2>&1")
  end
end
