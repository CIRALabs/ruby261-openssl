Instructions on building SHG image
----------------------------------

This uses Docker to do the building and processing.
At the end of the process, this is turned into a tgz for installation on the
secure home gateway (SHG).  The SHG does not run Docker!

docker build -t openssl-mcr:base -f base/Dockerfile base
docker build -t ruby261-openssl:margarita -f Dockerfile.arm .
