{% set distro = "el6" %}

add_ceph_extra_repo:
  file.managed:
    - source: salt://ceph/templates/ceph-extra.repo
    - name: /etc/yum.repos.d/ceph-extra.repo
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        distro: {{ distro }}

dd_ceph_repo_key:
  cmd.run:
    - name: rpm --import 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
   
add_ceph_repo:
  cmd.run:
    - name: rpm -Uvh http://ceph.com/rpms/{{distro}}/x86_64/ceph-{{release}}.el6.noarch.rpm   

ceph:
  user.present:
    - fullname: Ceph
    - home: /home/ceph
    - groups:
      - wheel

ceph-sudo-file:
  file.touch:
    - name: /etc/sudoers.d/ceph
    - mode: 0440
    - require:
      - user: ceph

ceph-sudo:
  file.append:
    - name: /etc/sudoers.d/ceph
    - text: ceph ALL = (root) NOPASSWD:ALL
    - require:
      - user: ceph
      - file: ceph-sudo-file

