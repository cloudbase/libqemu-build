FROM oraclelinux:7

WORKDIR /root

RUN yum groupinstall -y "Development Tools"
RUN yum install -y git glib2-devel libfdt-devel pixman-devel zlib-devel
RUN yum install -y libaio-devel libcap-devel libiscsi-devel
RUN yum install -y rpmdevtools

RUN mkdir -p /root/rpmbuild/SOURCES
RUN mkdir -p /root/rpmbuild/SPECS
