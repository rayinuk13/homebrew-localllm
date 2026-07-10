# homebrew-localllm

Homebrew tap for [localllm](https://github.com/rayinuk13/localllm) — download and run 63 LLMs locally. More models than Ollama.

## Install

```bash
brew tap rayinuk13/localllm
brew install localllm
```

## Usage

```bash
localllm list                   # all 63 models
localllm pull llama3.1-8b       # download
localllm run  llama3.1-8b       # run interactively
localllm search vision          # filter by capability
localllm search reasoning       # o1-style models
```
