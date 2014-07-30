{% set distro = "el6" %}
{% set full_distro = "centos6" %}
{% set ceph_release = "firefly" %}

ceph_repo:
  file.managed:
    - source: salt://ceph/templates/ceph.repo
    - name: /etc/yum.repos.d/ceph.repo
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        distro: {{ distro }}
        ceph_release: {{ ceph_release }}

ceph_extra_repo:
  file.managed:
    - source: salt://ceph/templates/ceph-extra.repo
    - name: /etc/yum.repos.d/ceph-extra.repo
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        full_distro: {{ full_distro }}

ceph_apache2_repo:
  file.managed:
    - source: salt://ceph/templates/ceph-apache2.repo
    - name: /etc/yum.repos.d/ceph-apache2.repo
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        distro: {{ distro }}

ceph_fastcgi_repo:
  file.managed:
    - source: salt://ceph/templates/ceph-fastcgi.repo
    - name: /etc/yum.repos.d/ceph-fastcgi.repo
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        distro: {{ distro }}

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

