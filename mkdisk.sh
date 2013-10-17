#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script prepare the disks

Ask() {
  if [ -z ${!2} ]
    then
    echo $1;
    read tmp;
    eval "$2=$tmp"
  fi
}

while true
do
  Ask "Disk device ?" DISK_DEVICE;
  if [ -w $DISK_DEVICE ]
    then break;
  else
    echo "device doesn't exist, or you don't have the permissions to write."
    DISK_DEVICE="";
    continue
  fi
done

while true
do
  parted -s $DISK_DEVICE print;

  Ask "Root Partition Size ?" ROOT_SIZE;
  Ask "Home Partition Size ?" HOME_SIZE;

  echo ""
  echo "Summary"
  echo "-------"
  echo ""
  echo -e "Install on : \t$DISK_DEVICE"
  echo -e "root : \t\t$ROOT_SIZE"
  echo -e "home : \t\t$HOME_SIZE"
  echo ""

  while true; do
      read -p "Good ? [y/n]" yn
      case $yn in
          [Yy]* ) yn=yes; break;;
          [Nn]* ) yn=no; break;;
          * ) echo "Please answer yes or no.";;
      esac
  done

  if [ $yn = yes ]
    then echo "ok--"; break;
  elif [ $yn = no ]
    then 
      DISK_DEVICE="";
      ROOT_SIZE="";
      HOME_SIZE="";
      echo "";
      continue;
  fi
done



