# Use Arch Linux as the base image
FROM archlinux:latest

# Update the system and install required packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
      base-devel \
      git \
      curl \
      inotify-tools \
      zsh \
      openssl \
      ncurses \
      wxgtk3 \
      libxslt \
      libxml2 \
      zlib \
      go \
      unzip \
      vim

# Switch back to root for the remaining installations.
USER root

# Set working directory for your application
WORKDIR /workspace

# (Optional) Reinstall inotify-tools if needed
RUN pacman -S --noconfirm inotify-tools

###############################
# Create a new user and install oh-my-zsh
###############################
# Create a non-root user named "developer" with zsh as the default shell.
RUN useradd -m -s /bin/zsh developer && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN git clone https://aur.archlinux.org/asdf-vm.git /opt/asdf-vm && \
    chown -R developer:developer /opt/asdf-vm

# Switch to the "developer" user.
USER developer
WORKDIR /home/developer

# Set the mix environment
ENV MIX_ENV=dev

###############################
# Install asdf from the AUR
###############################
RUN cd /opt/asdf-vm && \
    makepkg -si --noconfirm

ENV ASDF_DIR=/opt/asdf-vm
# Set kerl options to avoid building docs
ENV KERL_CONFIGURE_OPTIONS="--disable-debug --without-docs"

# Install Erlang and Elixir via asdf.
RUN asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    asdf install erlang 27.2.2 && \
    asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir 1.18.2-otp-27 && \
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
    asdf install nodejs 22.14.0

ENV ASDF_ERLANG_VERSION=27.2.2
ENV ASDF_ELIXIR_VERSION=1.18.2-otp-27
ENV ASDF_NODEJS_VERSION=22.14.0
ENV PATH="/home/developer/.asdf/shims:$PATH"

# Install oh-my-zsh unattended.
# The official install script can run non-interactively by setting RUNZSH and CHSH to "no".
RUN RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN echo "export ASDF_ERLANG_VERSION=27.2.2" >> /home/developer/.zshrc && \
    echo "export ASDF_ELIXIR_VERSION=1.18.2-otp-27" >> /home/developer/.zshrc && \
    echo "export ASDF_NODEJS_VERSION=22.14.0" >> /home/developer/.zshrc && \
    echo "export PATH=/home/developer/.asdf/shims:$PATH" >> /home/developer/.zshrc && \
    source /home/developer/.zshrc

# Install Hex and Rebar using mix (provided by the installed Elixir)
RUN /home/developer/.asdf/shims/mix local.hex --force && \
    /home/developer/.asdf/shims/mix local.rebar --force

# (Optionally, you can customize the .zshrc or add plugins here)
RUN sed -i.bak 's/plugins=(git)/plugins=(archlinux asdf docker git mix postgres)/' /home/developer/.zshrc
