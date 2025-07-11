FROM alpine:3.19

# Install dependencies
RUN apk add --no-cache bash curl unzip

# Install Terraform
ENV TERRAFORM_VERSION=1.8.5
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm -f terraform.zip

# Set workdir
WORKDIR /infrastructure

# Copy everything
COPY . /infrastructure/

# Make build.sh executable
RUN chmod +x /infrastructure/build.sh

# Default command
ENTRYPOINT ["/bin/bash", "/infrastructure/build.sh"]
