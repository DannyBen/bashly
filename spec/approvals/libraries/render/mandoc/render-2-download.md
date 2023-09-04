% cli-download(1) | Download a file
% 
% MONTH YEAR

NAME
==================================================

**cli download** - Download a file

SYNOPSIS
==================================================

**cli download** SOURCE [TARGET] [OPTIONS]

DESCRIPTION
==================================================

Download a file

- Alias: **d**

ARGUMENTS
==================================================

SOURCE
--------------------------------------------------

URL to download from

- *Required*

TARGET
--------------------------------------------------

Target filename (default: same as source)


OPTIONS
==================================================

--force, -f
--------------------------------------------------

Overwrite existing files


ENVIRONMENT VARIABLES
==================================================

DEFAULT_TARGET_LOCATION
--------------------------------------------------

Set the default location to download to


EXAMPLES
==================================================

~~~
cli download example.com

cli download example.com ./output -f

~~~

SEE ALSO
==================================================

**cli**(1)


