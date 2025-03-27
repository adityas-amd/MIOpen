# /bin/bash

#wget https://mkmartifactory.amd.com:8443/artifactory/system-provisioning/CodeQL/bundles/v2.20.6/codeql-bundle-linux64.tar.gz
#mkdir /tmp/codeql-bundle-linux64
#tar zxvf codeql-bundle-linux64.tar.gz -C /tmp/codeql-bundle-linux64
#rm codeql-bundle-linux64.tar.gz

export PATH=$PATH:/tmp/codeql-bundle-linux64/codeql
#env

# Get the full path of the script
script_path="$(readlink -f "$0")"
# Get the directory containing the script
script_dir="$(dirname "$script_path")"
parent_dir="$(dirname "$script_dir")"

echo "The full path of the script is: $script_path"
echo "The directory containing the script is: $script_dir"
echo "The repo root is $parent_dir"

db_location=/tmp/MIOpenCodeqlDB
build_location=$parent_dir/build

if [ -d $db_location ]; then
    echo "removing old db folder: $db_location"
    rm -r $db_location
fi

if [ -d $build_location ]; then
    echo "removing old build folder: $build_location"
    rm -r $build_location
fi

echo "Initializing db folder here: $db_location"
echo "Initializing build folder here: $build_location"


codeql database create $db_location --language=cpp --overwrite --source-root=$parent_dir --command=./codeql/codeql_build_command.sh

#generate csv output.
codeql database analyze $db_location --format=csv --output=codeql_results.csv cpp-security-extended.qls
