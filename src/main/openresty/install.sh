#!/bin/sh
{
yum install yum-utils
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install openresty-1.13.6.2-1.el7.centos -y

} | tee openresty.log
exit 0