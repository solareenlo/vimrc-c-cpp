# vimrc-c-cpp
- My `.vimrc` for c and cpp

## Usage
### c_formatter_42
```shell
echo "export PATH=$HOME/Library/Python/3.9/bin:$PATH" >> .zshrc
```

### ccls
```shell
curl -O https://raw.githubusercontent.com/solareenlo/vimrc-c-cpp/main/.ccls
```

### vim-autoformat
```shell
curl -O https://raw.githubusercontent.com/solareenlo/vimrc-c-cpp/main/.clang-format
echo "let g:python3_host_prog=\"$(which python3)\"" >> .vimrc
```

## References
- [solareenlo/42myvimrc](https://github.com/solareenlo/42myvimrc)

### c_formatter_42
- [dawnbeen/c_formatter_42](https://github.com/dawnbeen/c_formatter_42)
- [cacharle/c_formatter_42.vim](https://github.com/cacharle/c_formatter_42.vim)

### ccls
- [Configure .ccls file for Vim](https://stackoverflow.com/questions/63528459/configure-ccls-file-for-vim?rq=1)
- [MaskRay/ccls](https://github.com/MaskRay/ccls)
- ccls とは，c, cpp の LSP のサーバーのこと．
- [Implementations Language Servers](https://microsoft.github.io/language-server-protocol/implementors/servers/)

### clang-format
- `clang format` とは，c, cpp の formatter のこと．
- [C++ – clang-format の使い方、全オプションを解説](https://pystyle.info/cpp-how-to-use-clang-format/)
- [Clang Format Editor (Clang 13) version 0.3.0](https://pystyle.info/apps/clang-format-editor/)
- [Clang-Format Style Options](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
- [ClangFormat](https://clang.llvm.org/docs/ClangFormat.html)
