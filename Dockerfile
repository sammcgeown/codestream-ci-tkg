FROM sammcgeown/codestream-ci:latest
LABEL maintainer="smcgeown@vmware.com"

ENV GO_Version 1.15.2
ENV GOVC_Version v0.23.0

COPY kubernetes.repo /etc/yum.repos.d/

        # Install GO
RUN     wget --quiet https://dl.google.com/go/go$GO_Version.linux-amd64.tar.gz && \
        tar -C /usr/local -xzf go$GO_Version.linux-amd64.tar.gz && \
        export PATH=$PATH:/usr/local/go/bin && \
        source ~/.bash_profile && \
        # Download and Extract GOVC
        wget https://github.com/vmware/govmomi/releases/download/$GOVC_Version/govc_linux_amd64.gz && \
        gunzip -f govc_linux_amd64.gz && \
        mv govc_linux_amd64 govc && \
        chown root govc && \
        chmod ug+r+x govc && \
        mv govc /usr/local/bin/ && \
        # Install jq
        yum -yq install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
        curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
        yum install -yq jq nodejs kubectl expect && \
        npm install vmw-cli --global && \
        # Install yq
        wget https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64 -O /usr/bin/yq && \
        chmod +x /usr/bin/yq