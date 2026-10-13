class Localllm < Formula
  desc "Download and run LLMs locally. 98 models + OpenAI cloud. AES-256 encrypted keys."
  homepage "https://github.com/rayinuk13/localllm"
  url "https://github.com/rayinuk13/localllm/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "0e36651519923c0ff80463a1dc22515ad732db4d427dc6eaf39db4c57164e774"
  license "MIT"
  version "1.4.0"

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
      localllm v1.4.0 — dashboard + AES-256 encrypted keys

        localllm                  — dashboard with all commands
        localllm models           — full model browser (106 total)
        localllm download <id>    — download with live progress
        localllm run <id>         — run interactively
        localllm openai key sk-…  — save OpenAI key (AES-256 encrypted)
        localllm openai run gpt-4.1-mini

      All API keys are AES-256-GCM encrypted at rest, machine-locked.
      Config: ~/.localllm/config.json (chmod 600)
    EOS
  end

  test do
    assert_match "localllm", shell_output("#{bin}/localllm 2>&1")
  end
end
