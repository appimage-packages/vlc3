#!/bin/bash
sed -i -e 's|archive3.h|archive.h|g' ./shared.c
sed -i -e 's|archive_entry3.h|archive_entry.h|g' ./shared.c
sed -i -e 's|-larchive3|-larchive|g' ./build.sh

./build.sh
