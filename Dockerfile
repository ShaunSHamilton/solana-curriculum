FROM gitpod/workspace-full:2023-08-29-11-00-25

RUN sudo useradd -l -u 33333 -G sudo -md /workspace/solana-curriculum -s /bin/bash -p camper camper \
    # Remove `use_pty` option and enable passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e '/Defaults\tuse_pty/d' -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers \
    # To emulate the workspace-session behavior within dazzle build env
    && mkdir /workspace && chown -hR camper:camper /workspace

# Solana
RUN wget https://github.com/solana-labs/solana/releases/download/v1.16.9/solana-release-x86_64-unknown-linux-gnu.tar.bz2
RUN tar jxf solana-release-x86_64-unknown-linux-gnu.tar.bz2
ENV PATH="/home/gitpod/solana-release/bin:${PATH}"

WORKDIR /workspace/solana-curriculum
RUN npm install -g yarn @coral-xyz/anchor-cli@0.28.0

COPY --chown=camper:camper . .

USER camper

RUN npm install
