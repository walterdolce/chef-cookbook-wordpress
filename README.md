[![Build Status](https://travis-ci.org/walterdolce/chef-cookbook-wordpress.svg)](https://travis-ci.org/walterdolce/chef-cookbook-wordpress)

chef-cookbook-wordpress Cookbook
================================
This cookbook can download a Wordpress archive and install the instance.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - chef-cookbook-wordpress needs toaster to brown your bagel.

Attributes
----------

#### chef-cookbook-wordpress::downloader
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['protocol']</tt></td>
    <td>String</td>
    <td>the protocol to use to download Wordpress package</td>
    <td><tt>https</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['source']</tt></td>
    <td>String</td>
    <td>the default source to get Wordpress package</td>
    <td><tt>wordpress.org</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['package_version']</tt></td>
    <td>String</td>
    <td>the default (latest) Wordpress package version</td>
    <td><tt>latest</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['package_type']</tt></td>
    <td>String</td>
    <td>the default package type to get</td>
    <td><tt>zip</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['destination']</tt></td>
    <td>String</td>
    <td>the destination directory for the package</td>
    <td><tt>./</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['destination_filename']</tt></td>
    <td>String</td>
    <td>the destination filename</td>
    <td><tt>wordpress-latest</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['destination_dir_user']</tt></td>
    <td>String</td>
    <td>the user under which the destination directory path will be assigned</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['destination_dir_group']</tt></td>
    <td>String</td>
    <td>the group under which the destination directory path will be assigned</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['destination_file_user']</tt></td>
    <td>String</td>
    <td>the user under which the destination file will be assigned</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['wordpress']['downloader']['destination_file_group']</tt></td>
    <td>String</td>
    <td>the group under which the destination file will be assigned</td>
    <td><tt>root</tt></td>
  </tr>
</table>

Usage
-----
#### chef-cookbook-wordpress::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `chef-cookbook-wordpress` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-cookbook-wordpress]"
  ]
}
```

Contributing
------------

TODO: edit the steps below
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
