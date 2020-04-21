FROM debian:stretch
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git vim zsh openssl curl \
    && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k \
    && git clone https://github.com/thejonanshow/dotfiles.git && cd dotfiles && /bin/bash ./install.sh \
    && KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended; \
       echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc; \
       echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>~/.zshrc \
    && mkdir -p ~/.vim/after/syntax && echo 'syntax clear NERDTreeFlags' > ~/.vim/after/syntax/nerdtree.vim \
    && >~/.global.env; >~/.rubysetup; >~/.completion \
    && vim +PlugInstall +qall > /dev/null \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

ENV COLORTERM="truecolor" TERM="xterm-256color"
