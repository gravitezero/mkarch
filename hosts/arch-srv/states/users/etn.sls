etn:
  user.present:
    - fullname: Etienne Brodu
    - shell: /bin/zsh
    - home: /home/etn
    - password: {{ salt['pillar.get']('user_pw') }}
    - enforce_password: false
    - groups:
      - wheel
      - storage
    - require:
      - pkg: zsh

/home/etn/.ssh/authorized_keys:
  file.managed:
    - source: https://github.com/etnbrd.keys
    - makedirs: true
    - user: etn
    - group: etn
    - mode: 700
    - source_hash: sha512=957b4a9ff090773ba5298adf6af0a482f9876ac6947d1941c687162ee5ef5e16554b64f14f4971c4c427fe783bc05cf46de93d2643074f6c869866abebc90117
    - require.user: etn

/home/etn/.ssh/id_rsa:
  file.managed:
    - source: /srv/salt/credentials/id_rsa
    - require.user: etn 

/home/etn/.ssh/id_rsa.pub:
  file.managed:
    - source: /srv/salt/credentials/id_rsa.pub
    - require.user: etn 

/home/etn/.localrc:
  file.managed:
    - source: /srv/salt/config/.localrc
    - require.user: etn

git@github.com:etnbrd/dotfiles.git:
  git.latest:
    - target: /home/etn/.dotfiles
    - submodules: true
    - user: etn
    - identity: /home/etn/.ssh/id_rsa
    - require:
      - /home/etn/.ssh/id_rsa: file.managed