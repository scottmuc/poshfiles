Powershell Profile
==================

To install simply run the following in Powershell

<pre>
(new-object Net.WebClient).DownloadString("https://github.com/scottmuc/poshfiles/raw/master/install.ps1") | invoke-expression
</pre>

Features
--------

- Add any script to $env:UserProfile\poshfiles\scripts and it will be globally available
  look at Edit-Hosts.ps1 as an example
- Creates a pretty prompt
- Imports all Script modules whenever powershell is run
- Sets up your $env:Path so all directories in $env:UserProfile\bin are globally available

TODO
----

- Instructions on how to fork, modify the installer, and have your own custom powershell profile
