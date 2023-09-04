% cli-download(1) | Download a file
% 
% September 2023

NAME
==================================================

**cli download** - Download a file

SYNOPSIS
==================================================

**cli download** SOURCE [TARGET] [OPTIONS] [AWS PARAMS...]

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


AWS PARAMS...
--------------------------------------------------

Additional arguments or flags for AWS CLI


OPTIONS
==================================================

--force, -f
--------------------------------------------------

Overwrite existing files


EXAMPLES
==================================================

~~~
cli download example.com

cli download example.com ./output -f

~~~

SEE ALSO
==================================================

**cli**(1)


