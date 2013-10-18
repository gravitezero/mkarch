#!/bin/bash
#
# mkbase.sh by etnbrd
# This script install the base system

#####################################################
# PROMPT                                            #
#####################################################

Init

while true
do

  Ask "Bootloader ?" BOOTLOADER
  Ask "Packages to install ?" BASE
  Ask "Hostname ?" HOSTNAME
  Ask "Time zone ?" LOCALZONE

  echo -e "${BIWhi}"
  echo -e "$IF $DISK_DEVICE"
  echo -e "${BIWhi}   Base Packages \t${BIYel}$BASE"
  echo -e "${BIWhi}   Hostname \t${BIYel}$HOSTNAME"
  echo -e "${BIWhi}   Time zone \t${BIYel}$LOCALZONE"
  echo -e "${Rst}"

  yn=yes;
  while [[ $ASK = true ]]; do
      echo -ne "$PR Continue ? ${Rst}[${IBla}yes/no${Rst}] "
      read yn
      case $yn in
          [Yy]* ) yn=yes; break;;
          [Nn]* ) yn=no; break;;
          * ) echo "Please answer yes or no.";;
      esac
  done

  if [ $yn = yes ]
    then break;
  elif [ $yn = no ]
    then 
      Init
      echo;
      continue;
  fi
done

#####################################################
# COMMANDS                                          #
#####################################################

mount $DISK_DEVICE1 /mnt &&
mkdir -p /mnt/home &&
mount $DISK_DEVICE2 /mnt/home;
Error $? "$ER Failed to mount partitions" "$IF Partitions mounted";

pacstrap /mnt "$BASE";
Error $? "$ER ${BWhi}pacstrap${Rst} failed" "$IF Basecamp established, starting campfire :)"

genfstab -U -p /mnt >> /mnt/etc/fstab


echo "${BIGre}>> Success, we made it to the ARCH-CHROUT, time to unpack salt, and let it roll :)"

# arch-chroot $MNT << EOF
# echo $HOSTNAME >> /etc/hostname
# ln -s /usr/share/zoneinfo/$LOCALZONE /etc/localtime
# locale-gen


# TODO make an etc/vconsole.conf and echo it
# echo  >> /etc/vconsole.conf


# mkinitcpio -p linux
# TODO do the bootloader
# TODO do the root password

exit;