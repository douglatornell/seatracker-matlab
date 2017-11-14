function [t_mask, e1u, e2v, e3w0, totaldepth] = initialize_mesh(mesh_mask_file);

t_mask = ncread(mesh_mask_file, 'tmask');
e1u = ncread(mesh_mask_file, 'e1u');
e2v = ncread(mesh_mask_file, 'e2v');
e3w0 = ncread(mesh_mask_file, 'e3w_0');
mbathy = ncread(mesh_mask_file, 'mbathy');
gdepw_0 = ncread(mesh_mask_file, 'gdepw_0');
        
%totaldepth = np.empty_like(mbathy)
for i = 1:size(t_mask, 2)
    for j = 1:size(t_mask, 1)
        totaldepth(j, i) = gdepw_0(j, i, int8(mbathy(j, i))+1);
    end
end
