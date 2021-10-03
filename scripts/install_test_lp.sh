#!/usr/bin/env bash
language_packs=(language-dhis2 language-salesforce)
for language_pack in "${language_packs[@]}"; do
	releases=($(curl -H "Accept: application/vnd.github.json"  \
    https://api.github.com/repos/OpenFn/${language_pack}/releases \
    | jq -r '.[:2] | .[].assets[].browser_download_url | @sh' | tr -d \'))
	for build_url in "${releases[@]}"; do
		curl -L $build_url 2>/dev/null | tar xzf - ;
	done
done	

