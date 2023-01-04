#!/bin/bash

sandbox ()
{
    print $0 $1   
    if [[ -z $1 ]]; then
        print "No parameter"
    elif [[ $1 == "backup" ]]; then
        backup $2
    elif [[ $1 == "restore" ]]; then
        print "restore"
    else
        print "invalid parameter"
    fi
}

# UTM_IMAGE_FILE_PATH=~/dem
UTM_IMAGE_FILE_PATH=~/Library/Containers/com.utmapp.UTM/Data/Documents/dotenv-sandbox.utm
DEFAULT_BACKUP_DIR=~/.backup

backup ()
{
    BACKUP_DIR=$DEFAULT_BACKUP_DIR
    if [[ ! -z $1 ]]; then
        BACKUP_DIR=$1
    fi

    if [[ ! -d $BACKUP_DIR ]]; then
        echo "Backup directory not found. Creating..."
        mkdir -p $BACKUP_DIR
    fi

    if [[ ! -d $UTM_IMAGE_FILE_PATH ]]; then
        echo "Snapshot file does not exist on the path: $UTM_IMAGE_FILE_PATH"
        return
    fi

    SOURCE_DIR_NAME=${UTM_IMAGE_FILE_PATH##*/}
    DESTINATION_PATH=$BACKUP_DIR/$SOURCE_DIR_NAME

    if [[ -f $DESTINATION_PATH ]]; then
        echo "A backup with the name $SOURCE_DIR_NAME already exists."    
        read -k 1 "PASTE_OPTION?Would you like to [r]eplace/[k]eep both/[A]bort?: "
        echo

        if [[ $PASTE_OPTION == "r" ]]; then
            echo "Replacing old snapshot file with the new one, this might take a while."
        elif [[ $PASTE_OPTION == "k" ]]; then
            TIMESTAMP_SUFFIX="_$(date +"%d-%m-%y_%H:%M:%S")"
            echo "Creating a new snapshot copy with name: $SOURCE_DIR_NAME$TIMESTAMP_SUFFIX"
            DESTINATION_PATH+=$TIMESTAMP_SUFFIX
        else
           echo "Snapshot backup aborted." 
           return
        fi
    fi

    rsync -avrltD --stats --human-readable $UTM_IMAGE_FILE_PATH $DESTINATION_PATH | pv -lep -s 1000000000000

    echo "Done."
}
