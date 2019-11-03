FROM golang:latest AS builder

RUN go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login

FROM gradle:5.6.3-jdk11

LABEL maintainer="Mazunin Konstantin <mazuninky@gmail.com>"

#############
## AWS CLI ##
#############

RUN wget --no-verbose --output-document="awscli-bundle.zip" "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"; \
	unzip awscli-bundle.zip; \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws; \
	rm awscli-bundle.zip && rm -rf awscli-bundle

###################################
## Amazon ECR Docker Credential  ##
###################################

COPY --from=builder /go/bin /usr/local/bin