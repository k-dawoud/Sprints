#! /bin/bash

function error_free(){
        if(($?==0));
        then
                echo -e "Successful execution for creating \c"
        else
                echo "Unscessful execution with an error $1"
        fi
}

function listing_data(){
        ls -al *.txt
        ps aux > ./process_info.txt
        error_free
        echo "process information list"
        free -h > ./memory_info.txt
        error_free
        echo "memory usage list"
        df -h | awk '{print $1,$5,$6}' > ./disk_info.txt
        error_free
        echo "disk usage list"
        dmesg > ./dmesg.txt
        error_free
        echo "dmesg"
        ls -al *.txt
}

function validate_and_compress(){
        listing_data
        if [[ -f process_info.txt ]] && [[ -f memory_info.txt ]] && [[ -f disk_info.txt ]] && [[ -f dmesg.txt ]];
        then
                echo "Files are existed and will run the compressing..."
                tar -czf files_compressed.tar.gz process_info.txt memory_info.txt disk_info.txt dmesg.txt
                if [[ -f files_compressed.tar.gz ]];
                then
                        echo "Files are successfully compressed."
                        ls -al files_compressed.tar.gz
                else
                        echo "Error in compressing the file."
                fi
        else
                echo "There is a missing file."
        fi
}

function ssh_sending(){
        validate_and_compress
        read -p "Enter username: " v_username
        read -p "Enter IP: " v_ip
        read -p "Enter path: " v_path
        scp files_compressed.tar.gz $v_username@$v_ip:$v_path
}


ssh_sending
