# Installation

```
git clone git@github.com:enoodle/vimrc
```

Add `source ~/vimrc/vimrc` to your "~/.vimrc" file.

## YouCompleteMe
Depends on cmake, c++ compiler (gcc-c++), python-devel, go, node
```
cd ~/.vim/bundle/YouCompleteMe
./install.py
```

For more information go to https://valloric.github.io/YouCompleteMe/#installation

## Recompile VIM with ruby bindings for better ruby support
To get better ruby support I compile vim with the RVM's (or your prefered package and binary manager) path using something like this guid: http://arjanvandergaag.nl/blog/compiling-vim-with-ruby-support.html
