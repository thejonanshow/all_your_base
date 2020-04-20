FROM debian:stretch
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates git vim zsh openssl curl
RUN git clone https://github.com/thejonanshow/dotfiles.git && cd dotfiles && /bin/bash ./install.sh
RUN >~/.global.env; >~/.rubysetup; >~/.completion
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended \
  && echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc \
  && echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>~/.zshrc
ENV COLORTERM truecolor
ENV TERM xterm-256color
RUN mkdir -p ~/.vim/after/syntax && echo 'syntax clear NERDTreeFlags' > ~/.vim/after/syntax/nerdtree.vim
