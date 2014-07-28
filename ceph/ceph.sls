{% set ceph_release = "firefly" %}
{% set distro = "el6" %}
{% set release = "el6" %}
ceph-repo:
  pkgrepo.managed:
    - humanname: Ceph Repo
    - file: /etc/yum/yum.repos.d/ceph.repo
    - gpgcheck: 1
    - key_url: https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc


