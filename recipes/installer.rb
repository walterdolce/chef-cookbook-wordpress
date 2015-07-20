
if node[:wordpress].attribute?(:installer) && node[:wordpress][:installer].attribute?(:downloaded_archive)
  archive node[:wordpress][:installer][:downloaded_archive]
end
