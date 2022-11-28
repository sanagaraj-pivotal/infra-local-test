function waitAndLogInitContainer() {
    local podName=$1
    local intContainerName=$2
    local maximumWaitTime=$3

    for i in {0..$maximumWaitTime}
    do
      sleep 1
      outputLength=$(kubectl logs $podName -c $intContainerName | wc -c | bc)

      if [ $outputLength -gt 0 ]
      then
        kubectl logs -f $podName -c $intContainerName
        return 0
      fi
    done

    echo "Unable to load logs of $podName - $intContainerName hence exiting"
    exit 1
}
