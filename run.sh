APT_LIST_PATH=$WERCKER_CACHE_DIR/wercker/apt-lists
MAX_TRIES=3
try=1

retry() {

    try=$((try+1))

    if [ "$try" -gt "$MAX_TRIES" ]; then
        fail "Retry exceeds max retries";
    fi

    if [ "$WERCKER_INSTALL_PACKAGES_CLEAR_CACHE" = "true" ]; then
        info "Clearing the cache: $WERCKER_CACHE_DIR/wercker"
        rm -f $WERCKER_CACHE_DIR/wercker/aptupdated && rm -rf $APT_LIST_PATH
    else
        info "Skipping clearing cache; WERCKER_INSTALL_PACKAGES_CLEAR_CACHE is not set to true";
    fi

    info "Retrying apt-get-install, try: $try";
    exec_install_packages;
}

exec_install_packages(){
  mkdir -p $APT_LIST_PATH
  sudo rm -fr /var/lib/apt/lists
  sudo ln -s $APT_LIST_PATH/ /var/lib/apt/lists
  if [ $( find $WERCKER_CACHE_DIR/wercker/aptupdated -mtime -1 | wc -l ) -eq 0 ] ;
  then sudo apt-get update; touch $WERCKER_CACHE_DIR/wercker/aptupdated;  fi

  sudo apt-get install $WERCKER_INSTALL_PACKAGES_PACKAGES -y

  if [[ $? -ne 0 ]]; then
    info "Unable to execute apt-get-install"
    retry
  fi
}

exec_install_packages
