grunt-cli:
  npm:
    - installed
  require:
    - pkg: nodejs

sass:
  cmd.run:
    - name: gem install --no-user-install sass
  require:
    - pkg: ruby

bourbon:
  cmd.run:
    - name: gem install --no-user-install bourbon
  require:
    - pkg: ruby

/usr/lib/systemd/system/ghost.service:
  file.managed:
    - source: salt://srv/ghost/ghost.service
    - user: root
    - group: root
    - mode: 644

ghost:
  git.latest:
    - name: https://github.com/TryGhost/Ghost.git
    - target: /srv/http/ghost
    - submodules: true
    - rev: master
  cmd.wait:
    - name: 'npm install && grunt'
    - cwd: /srv/http/ghost
    - watch:
      - git: ghost
  cmd.wait:
    - name: 'bourbon install'
    - cwd: /srv/http/ghost/core/client/assets/sass
    - watch:
      - git: ghost
  service.running:
    - name: ghost
    - enable: True
    - reload: True
  require:
    - pkg: nodejs
    - npm: grunt-cli
    - cmd: sass
    - cmd: bourbon
    - file: /usr/lib/systemd/system/ghost.service