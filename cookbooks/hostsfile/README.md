hostsfile LWRP
==============
`hostsfile` provides an LWRP for managing your hosts file using Chef.

Requirements
------------
At this time, you must have a Unix-based machine. This could easily be adapted for Windows machines. Please submit a Pull Request if you wish to add Windows support.

Attributes
----------
<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Example</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>ip_address</td>
    <td>(name attribute) the IP address for the entry</td>
    <td><tt>1.2.3.4</tt></td>
    <td></td>
  </tr>
  <tr>
    <td>hostname</td>
    <td>(required) the hostname associated with the entry</td>
    <td><tt>example.com</tt></td>
    <td></td>
  </tr>
  <tr>
    <td>aliases</td>
    <td>array of aliases for the entry</td>
    <td><tt>['www.example.com']</tt></td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td>comment</td>
    <td>a comment to append to the end of the entry</td>
    <td><tt>'interal DNS server'</tt></td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Actions
-------
**Please note**: As of `v0.1.2`, specifying a hostname or alias that exists in another entry will remove that hostname from the other entry before adding to this one. For example:

    1.2.3.4          example.com www.example.com

and

```ruby
hostsfile_entry '2.3.4.5' do
  hostname 'www.example.com'
end
```

would yield an /etc/hosts file like this:

    1.2.3.4          example.com
    2.3.4.5          www.example.com

#### `create`
Creates a new hosts file entry. If an entry already exists, it will be overwritten by this one.

```ruby
hostsfile_entry '1.2.3.4' do
  hostname 'example.com'
  action :create
end
```

This will create an entry like this:

    1.2.3.4          example.com

#### `create_if_missing`
Create a new hosts file entry, only if one does not already exist for the given IP address. If one exists, this does nothing.

```ruby
hostsfile_entry '1.2.3.4' do
  hostname 'example.com'
  action :create_if_missing
end
```

#### `append`
Append a hostname or alias to an existing record. If the given IP address doesn't not already exist in the hostsfile, this method behaves the same as create. Otherwise, it will append the additional hostname and aliases to the existing entry.

    1.2.3.4         example.com www.example.com # Created by Chef

```ruby
hostsfile_entry '1.2.3.4' do
  hostname 'www2.example.com'
  aliases ['foo.com', 'foobar.com']
  comment 'Append by Recipe X'
end
```

would yield:

    1.2.3.4         example.com www.example.com www2.example.com foo.com foobar.com # Created by Chef, Appended by Recipe X


#### `update`
Updates the given hosts file entry. Does nothing if the entry does not exist.

```ruby
hostsfile_entry '1.2.3.4' do
  hostname 'example.com'
  comment 'Update by Chef'
  action :update
end
```

This will create an entry like this:

    1.2.3.4           example # Updated by Chef

#### `remove`
Removes an entry from the hosts file. Does nothing if the entry does not
exist.

```ruby
hostsfile_entry '1.2.3.4' do
  action :remove
end
```

This will remove the entry for `1.2.3.4`.

Usage
-----
Download or install this cookbook from the community site:

    $ knife cookbook site install hostsfile

Have your cookbook depend on hostsfile by editing editing the metadata.rb for your cookbook.

```ruby
# metadata.rb
depends 'hostsfile'
```

Contributing
------------
1. Fork the project
2. Create a feature branch corresponding to you change
3. Commit and test thoroughly
4. Create a Pull Request on github
    - ensure you add a detailed description of your changes

License and Authors
-------------------
Authors: [Seth Vargo](https://github.com/sethvargo) ([@sethvargo](https://twitter.com/sethvargo))

Copyright 2012, CustomInk, LLC
