FROM alpine:latest as base

# allow testing packages
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# base build tools, which takes longer to install
RUN apk add -Uu alpine-sdk linux-lts-dev linux-headers build-base clang go rust python3 perl dotnet6-sdk dotnet7-sdk openjdk20@testing

# all other tools
RUN apk add -Uu bash zsh fzf vim nano git mercurial parallel grep gawk sed wget curl less pv ipython strace perf bcc bpftrace

# man pages for all installed packages
#   this forces install packages with the -doc suffix and then force remove packages that were not found
RUN apk add -Uu man-pages mandoc mandoc-apropos
RUN apk add -Uu -f $(apk list -I | awk '{printf "%s-doc ", $3}' | tr -d {})
RUN apk add | grep '(no such package)' | awk '{print $1}' | xargs apk del -f

# zshrc with personal preferences + startups commands
COPY zshrc /root/.zshrc