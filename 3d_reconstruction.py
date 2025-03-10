import numpy as np
import glob
from PIL import Image
import cv2
import json
import math
import os
import time
import h5py


def DLT(coordinates, p_s):
    A = []
    for i in range(len(coordinates)):
        x = coordinates[i][0]
        y = coordinates[i][1]
        p1 = p_s[i][0,:]
        p2 = p_s[i][1,:]
        p3 = p_s[i][2,:]
        A.append(y*p3 - p2)
        A.append(p1 - x*p3)

    A = np.array(A).reshape((-1,4))
    B = A.transpose() @ A
    U, s, Vh = np.linalg.svd(B, full_matrices = False)
 
    return Vh[-1,:]

def config_parser():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--base_path", type=str, help="base folder path")
    parser.add_argument("--id", type=int, help="id number of species")
    return parser.parse_args()


args = config_parser()

base_path = args.base_path 
sd_labels = ['camera1','camera2','camera3','camera4','camera5','camera6','camera7','camera8']

original_folder_list = glob.glob(base_path + "/crop_undistort/*")
original_folder_list.sort()

cam_para_file = base_path + '/camera_parameters.h5'
f_param = h5py.File(cam_para_file, 'r')


species_number = args.id
match_number = 2 #number of correspondence view. minimum is 2. 4 gives less noise 3d point cloud but less point on body part.

print(species_number)
species_index = species_number - 1
name = os.path.basename(original_folder_list[species_index])

x,y = f_param["crop/offset"][species_index]
w,h = f_param["crop/img_size"][species_index]

cor_folder = base_path + "/correspondence_undistort/" + name + "/"
cor_file = cor_folder + "correspondence_coordinate.h5"
f_cor = h5py.File(cor_file, 'r')

cor_0_dic = {'camera1':None,'camera2':None,'camera3':None,'camera4':None,'camera5':None,'camera6':None,'camera7':None,'camera8':None}
cor_20_dic = {'camera1':None,'camera2':None,'camera3':None,'camera4':None,'camera5':None,'camera6':None,'camera7':None,'camera8':None}

undist_0_dic = {'camera1':None,'camera2':None,'camera3':None,'camera4':None,'camera5':None,'camera6':None,'camera7':None,'camera8':None}
undist_20_dic = {'camera1':None,'camera2':None,'camera3':None,'camera4':None,'camera5':None,'camera6':None,'camera7':None,'camera8':None}

p_list = [0 for l in range(16)]

num_0 = []
num_20 = []

for count, c in enumerate(sd_labels):
    mtx = f_param[c]['mtx_undistort'][:]
    dist = f_param[c]['dist'][:]

    cor_0_dic[c] = f_cor['0'][c][:]
    cor_20_dic[c] = f_cor['20'][c][:]

    rvec = f_param[c]['rvec'][0]
    tvec = f_param[c]['tvec'][0]

    mtx[0,2] -= x
    mtx[1,2] -= y
    p_list[count] = mtx @ np.concatenate([rvec,tvec], axis=1)
    undist_0_dic[c] = cor_0_dic[c][:,0:2]

    rvec = f_param[c]['rvec'][20]
    tvec = f_param[c]['tvec'][20]
    p_list[count + 8] = mtx @ np.concatenate([rvec,tvec], axis=1)
    undist_20_dic[c] = cor_20_dic[c][:,0:2]

    num_0.append(len(cor_0_dic[c][:,2]))
    num_20.append(len(cor_20_dic[c][:,2]))


map_bottom_0 = np.zeros((max(num_0[0:4]),4), dtype=int)
map_top_0 = np.zeros((max(num_0[4:]),4), dtype=int)
map_bottom_20 = np.zeros((max(num_20[0:4]),4), dtype=int)
map_top_20 = np.zeros((max(num_20[4:]),4), dtype=int)

for count, c in enumerate(sd_labels):
    if count < 4:
        map_bottom_0[0:num_0[count],count] = cor_0_dic[c][:,2]
        map_bottom_20[0:num_20[count],count] = cor_20_dic[c][:,2]
    else:
        count2 = count - 4
        map_top_0[0:num_0[count],count2] = cor_0_dic[c][:,2]
        map_top_20[0:num_20[count],count2] = cor_20_dic[c][:,2]

#matching
coordinates_3d_list = []
coordinates_3d_list_noba = []
rgb_list = []
b_images_0 = []
b_images_20 = []
for count, c in enumerate(sd_labels):
    img_name = original_folder_list[species_index] + "/" + name[4:] + "-" + c + "-" + "00" + ".png"
    b_images_0.append(cv2.cvtColor(cv2.imread(img_name), cv2.COLOR_BGR2RGB))
    img_name = original_folder_list[species_index] + "/" + name[4:] + "-" + c + "-" + "20" + ".png"
    b_images_20.append(cv2.cvtColor(cv2.imread(img_name), cv2.COLOR_BGR2RGB))

temp_map_list = [map_bottom_0,map_top_0,map_bottom_20,map_top_20]
camera_id_offset = [0,4,0,4]

zp = np.array([0.0,0.0])
coordinates_2d_list = []
distorted_coordinates_2d_list = []
mask_list = []


for k in range(4):
    temp_map = temp_map_list[k]
    vals = np.trim_zeros(np.unique(temp_map))
    match_list = []
    for count, i in enumerate(vals):
        match = np.argwhere(temp_map==i)
        if match.shape[0] >= match_number:
            match_list.append(match)

    for i in match_list:
        coordinates_array = np.array([zp for l in range(16)])
        mask = np.array([0.0 for l in range(16)])
        coordinates = []
        p_s = []
        rgb_s = []
        for j in range(len(i)):
            point_id = i[j][0]
            camera_id = i[j][1] + camera_id_offset[k]
            if k < 2:
                coordinates_array[camera_id] = undist_0_dic[sd_labels[camera_id]][point_id]
                mask[camera_id] = 1.0
                coordinates.append(undist_0_dic[sd_labels[camera_id]][point_id])
                x_pos = int(cor_0_dic[sd_labels[camera_id]][point_id][0])
                y_pos = int(cor_0_dic[sd_labels[camera_id]][point_id][1])
                rgb_s.append(b_images_0[camera_id][y_pos,x_pos])
                p_s.append(p_list[camera_id])
            else:
                coordinates_array[camera_id + 8] = undist_20_dic[sd_labels[camera_id]][point_id]
                mask[camera_id + 8] = 1.0
                coordinates.append(undist_20_dic[sd_labels[camera_id]][point_id])
                x_pos = int(cor_20_dic[sd_labels[camera_id]][point_id][0])
                y_pos = int(cor_20_dic[sd_labels[camera_id]][point_id][1])
                rgb_s.append(b_images_20[camera_id][y_pos,x_pos])
                p_s.append(p_list[camera_id + 8])

        X = DLT(coordinates,p_s)
        rgb = np.average(np.array(rgb_s), axis=0)
        coordinates_3d_list_noba.append(X[0:3]/X[-1])
        coordinates_3d_list.append(X)
        coordinates_2d_list.append(coordinates_array)
        mask_list.append(mask)
        rgb_list.append(rgb)

coordinates_3d_list = np.array(coordinates_3d_list)
p_list = np.array(p_list)
coordinates_2d_list = np.array(coordinates_2d_list)
mask_list = np.array(mask_list)
rgb_list = np.array(rgb_list)

mask_list = mask_list.T
c_input = coordinates_2d_list
coordinates_3d_list = coordinates_3d_list.T
ba_bool = False

if ba_bool:
    coordinates_3d_list_ba = bundle_adjustment.main(c_input,mask_list,p_list,coordinates_3d_list)



import open3d as o3d
pcd = o3d.geometry.PointCloud()
if ba_bool:
    pcd.points = o3d.utility.Vector3dVector(coordinates_3d_list_ba)
else:
    pcd.points = o3d.utility.Vector3dVector(coordinates_3d_list_noba)

pcd.colors = o3d.utility.Vector3dVector(rgb_list/255)

import math
import itertools
bounds = [[-math.inf, math.inf], [-math.inf, math.inf], [-20, 20]]
bounds = [[-math.inf, math.inf], [-math.inf, math.inf], [-60, 60]]
bounding_box_points = list(itertools.product(*bounds))
bounding_box = o3d.geometry.AxisAlignedBoundingBox.create_from_points(
    o3d.utility.Vector3dVector(bounding_box_points))

# Crop the point cloud using the bounding box:
pcd_croped = pcd.crop(bounding_box)

o3d.visualization.draw_geometries([pcd_croped])

o3d.io.write_point_cloud(cor_folder + "/" + name + ".pcd", pcd)
