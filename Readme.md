# Docker Image Based on [Letse](https://github.com/c4milo/letse)
### Uses LetsEncrypt DNS Challenge for Route53
### Expects that [AWS credentials](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-environment) are setup (so that they can be supplied to the Docker container)

<pre>
<code>
# to build
docker build -t letse-docker .
# to generate new certificate
docker run -v ~/.aws/:/root/.aws -v certificate_output_path:/etc/certs letse-docker new domain_name
# to renew certificate
docker run -v ~/.aws/:/root/.aws -v certificate_output_path:/etc/certs letse-docker renew domain_name
# alternatively you can pass AWS credentials as env variables
docker run -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -v certificate_output_path:/etc/certs letse-docker new domain_name
# similarly for renewal
</code>
</pre>

### Certificates will be stored in `certificate_output_path` as `domain_name-fullchain.pem` and `domain_name.key` alongwith [Diffie-Helman](https://wiki.openssl.org/index.php/Diffie-Hellman_parameters) parameters as `dhparams.pem`

### pull pre-built image from DockerHub `docker pull shreyask/letse-docker`
