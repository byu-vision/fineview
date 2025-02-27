#!/bin/bash

curl -L https://byu.box.com/shared/static/vuy7fk0wgj33592hj34xsc38m18wx0vk.zip --output crop_undistort_8.zip
curl -L https://byu.box.com/shared/static/tk3r4zsa3doe4i56t2vibjz0nyzl9is9.zip --output crop_mask_undistort_8.zip

unzip crop_undistort_8.zip
unzip crop_mask_undistort_8.zip

rm crop_undistort_8.zip
rm crop_mask_undistort_8.zip



