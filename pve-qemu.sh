#!/bin/bash

qemu_check=$(kvm --version)

echo "QEMU Downgrade Script"

if echo "$qemu_check" | grep -q "pve-qemu-kvm_9.0.0-3"; then
    echo "You can downgrade the QEMU version! (9.0.0-3 -> 8.x)"
    
    echo "Downloading pve-qemu-kvm_8.1.5-6_amd64"
    if wget "http://download.proxmox.com/debian/pve/dists/bookworm/pve-no-subscription/binary-amd64/pve-qemu-kvm_8.1.5-6_amd64.deb"; then
        echo "Download successful"

        if dpkg -i "pve-qemu-kvm_8.1.5-6_amd64.deb"; then
            echo "Installing successful"
        fi

        while true; do
            read -p "Do you want to reboot now? (y/n): " answer
            case $answer in
                [Yy]* )
                    echo "Rebooting.."
                    reboot
                    exit 0
                    ;;
                [Nn]* )
                    echo "Aborted"
                    exit 0
                    ;;
                * )
                    echo "Invaild input, Aborted"
                    exit 0
                    ;;
            esac
        done
    else
        echo "Download failed, Check your Internet or other issues"
        exit 1
    fi

else
    echo "Your QEMU version is already 8.x, No need to downgrade"
fi