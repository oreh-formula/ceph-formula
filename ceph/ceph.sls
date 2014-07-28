{% set ceph_release = "firefly" %}
{% set distro = "el6" %}
{% set release = "el6" %}
ceph-repo:
  pkgrepo.managed:
    - humanname: Ceph Repo
    - baseurl: http://ceph.com/rpm-{{ceph_release}}/{{distro}}/noarch
    - file: /etc/yum/yum.repos.d/ceph.repo
    - gpgcheck: 1
    - gpgkey: https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc
    - require_in:
      - pkg: ceph-deploy

ceph-deploy:
  pkg.installed


ceph:
  user.present:
    - fullname: Ceph
    - home: /home/ceph
    - groups:
      - wheel

/etc/sudoers.d/ceph:
  file.exists
    - require:
      - user: ceph

ceph-sudo:
  file.append:
    - name: /etc/sudoers.d/ceph
    - text: ceph ALL = (root) NOPASSWD:ALL
    - require:
      - user: ceph
      - file: /etc/sudoers.d/ceph
  cmd.run:
    - chmod 0440 /etc/sudoers.d/ceph
    - require:
      - user: ceph
      - file: /etc/sudoers.d/ceph

