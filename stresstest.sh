#!/bin/bash

#function to display menu
display_menu() {
    clear
    echo "================  Stresstest Menu ===================="
    echo "                                                      "
    echo "                    ▄▄                          ▄▄    "
    echo "                   ▄██                        ▀███    "
    echo "                    ██                          ██    "
    echo "  █▄▄▄▄▄▄ ▄██▀▀██▄  ██▄████▄ ▀██▀   ▀██▀   ▄█▀▀███    "
    echo " ▄█      ██▀    ▀██ ██    ▀██  ██   ▄█   ▄██    ██    "
    echo " █████▄▄ ██      ██ ██     ██   ██ ▄█    ███    ██    "
    echo "      ▀████▄    ▄██ ██▄   ▄██    ███     ▀██    ██    "
    echo " █     ██ ▀██████▀  █▀█████▀      █       ▀████▀███▄  "
    echo "███  ▄██                                              "
    echo "█████                                                 "
    echo "                                                      "                                    
    echo "======================================================"
    echo "1. Test CPU                                           "
    echo "2. Test Memory                                        "
    echo "3. Test Disk                                          "
    echo "4. Quit                                               "
    echo "======================================================"
    echo -n "Choose an option: "
}
#function to test the CPU
test_cpu() {
    echo "Testing CPU..."
    while true; do
        :
    done
}
#function to test the memory
test_memory() {
    echo "Testing memory..."
    size=$(free -m | awk '/Mem:/{print $2}')
    array=()
    while true; do
        array+=($(seq 1 1024 $((1024*1024*size))))
    done
}
#function to test the disk
test_disk() {
    echo "Testing disk..."
    dd if=/dev/urandom of=/tmp/testfile bs=1M count=$(df --output=avail / | tail -n 1 | awk '{print int($1 / 1024)}')
    rm /tmp/testfile
    echo "Disk test completed."
    read -n 1 -s -r -p "Press any key to continue..."
}
#main loop of the program
while true; do
    display_menu 
    read choice

    case $choice in
        1)
            test_cpu &
            echo "Press any key to stop the test..."
            read -n 1 -s -r
            kill $!
            ;;
        2)
            test_memory &
            echo "Press any key to stop the test..."
            read -n 1 -s -r
            kill $!
            ;;
        3)
            test_disk
            ;;
        4)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose a valid option."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
    esac
done
