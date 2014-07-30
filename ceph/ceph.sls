{% set distro = "el6" %}

add_ceph_extra_repo:
  file.managed:
    - source: salt://ceph/templates/ceph-extra.repo
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        distro: {{ distro }}

ceph-deploy:
  pkg.installed


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

