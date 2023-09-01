FROM gitpod/workspace-full:2023-08-29-11-00-25

# Solana
RUN wget https://github.com/solana-labs/solana/releases/download/v1.16.9/solana-release-x86_64-unknown-linux-gnu.tar.bz2
RUN tar jxf solana-release-x86_64-unknown-linux-gnu.tar.bz2
ENV PATH="/home/gitpod/solana-release/bin:${PATH}"

WORKDIR /workspace/solana-curriculum
RUN npm install -g yarn @coral-xyz/anchor-cli@0.28.0

COPY --chown=gitpod:gitpod . .

RUN chown -hR gitpod:gitpod /workspace

RUN npm install
