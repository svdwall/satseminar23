# Nix builder
FROM nixos/nix:latest 

# Copy our source and setup our working dir.
COPY . /tmp/build
WORKDIR /tmp/build

# Build our Nix environment
RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    profile install .

RUN mkdir benchmarks
RUN tar -xvf bench/inductive-inference.tar.gz -C benchmarks
RUN tar -xvf bench/php.tar.gz -C benchmarks
