#!/bin/sh -l

rpmdir=~/rpmbuild/RPMS/x86_64
nexus=https://wvwx3.gst.com
repo=gst-wx
path=/metlab/v1.10/x86_64
user="gst-wx-yum"
pass=
file=
args=""

function usage {
	echo "$0 [--url <url>] [--repo <repo>] [--path <path>] [--file <file>] [--user <user>] [--pass <password>]"
	echo "  --url    url of YUM server ($url)"
	echo "  --repo   path to repo ($repo)"
	echo "  --rpmdir directory of rpm files ($rpmdir)"
	echo "  --path   path within YUM server for file ($path)"
	echo "  --file   file to upload ($file)"
	echo "  --user   username for authentication ($user)"
	echo "  --pass   password for authentication ($pass)"
	echo "  --args   add arguments"
	echo "  --http1.1  use http1.1 protocol (instead of http/2)"
	exit 1;
}

while [ $# -gt 0 ]
do
	case $1 in
	--url) shift; nexus=$1;;
	--repo) shift; repo=$1;;
	--path) shift; path=$1;;
	--user) shift; user=$1;;
	--pass) shift; pass=$1;;
	--file) shift; file=$1;;
	--http1.1) args="$args --http1.1";;
	--args) shift; args="$args $1";;
	--rpmdir) shift; rpmdir=$1;;
	*) usage;;
	esac
	shift
done

url="${nexus}/repository/${repo}${path}"

pwd=$(pwd)
cd "${rpmdir}" || exit 1
echo "curl ${args} -u ${user}:${pass} --upload-file ${file}  ${url}/${file}"

# shellcheck disable=SC2086
curl ${args} -u "${user}":"${pass}" --upload-file "${file}"  "${url}/${file}"
curl_status=$?
cd "${pwd}" || exit 1
exit "${curl_status}"

#groovy /opt/sonatype/bin/NexusPublisher.groovy --serverurl "${nexus}" --username "{user}" --password "${pass}" --format rpm --repository "${repo}" --filename "${GITHUB_WORKSPACE}/${file}" $(echo -C$6 | sed 's/ / -C/g') $(echo -A$7 | sed 's/ / -A/g')
