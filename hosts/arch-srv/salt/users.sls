etn:
  user.present:
    - fullname: Etienne Brodu
    - shell: /bin/zsh
    - home: /home/etn
    - password: {{ salt['pillar.get']('user_pw') }}
    - groups:
      - wheel
      - storage
    - require:
      - pkg: zsh